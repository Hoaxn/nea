import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/core/common/snackbar/snackbar.dart';
import 'package:flutterapi/core/common/widget/drawer_widget.dart';
import 'package:flutterapi/features/exceeded_hours/data/data_source/exceeded_hours_data_source.dart';
import 'package:flutterapi/features/exceeded_hours/presentation/viewmodel/exceeded_hours_viewmodel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

class SevenHourExceededScreen extends ConsumerStatefulWidget {
  const SevenHourExceededScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SevenHourExceededScreenState();
}

class _SevenHourExceededScreenState
    extends ConsumerState<SevenHourExceededScreen> {
  final _language = Language.english;

  final _dateOrder = DateOrder.ymd;

  NepaliDateTime? startDate;
  NepaliDateTime? endDate;

  Future<void> _showNepaliDatePicker(
      BuildContext context, bool isStartDate) async {
    final NepaliDateTime? selectedDateTime =
        await picker.showAdaptiveDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime(2090),
      language: _language,
      dateOrder: _dateOrder,
    );
    if (selectedDateTime != null) {
      setState(() {
        if (isStartDate) {
          startDate = selectedDateTime;
        } else {
          endDate = selectedDateTime;
        }
      });

      await ref.read(exceededHoursRemoteDataSourceProvider).getExceededHours(
            startDate: startDate,
            endDate: endDate,
          );
    }
  }

  Future<void> _handleRefresh() async {
    final exceededHoursRefresh =
        ref.read(exceededHoursViewModelProvider.notifier);
    await exceededHoursRefresh.getExceededHours(
      startDate: startDate,
      endDate: endDate,
    );
    await Future.delayed(const Duration(seconds: 1));
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final exceededHoursDataView = ref.watch(exceededHoursViewModelProvider);

    const gap = SizedBox(
      height: 10,
    );

    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        height: deviceHeight * 0.25,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: openDrawer,
                        child: const Icon(Icons.menu),
                      ),
                      const Text(
                        "Exceeded Hours Report",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.lightBlueAccent.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 11.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _showNepaliDatePicker(context, true);
                                  },
                                  child: Icon(
                                    Icons.edit_calendar_outlined,
                                    color: Colors.lightBlue[300],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (startDate == null && endDate == null) {
                                      showSnackBar(
                                        message:
                                            "Enter both the starting and ending dates",
                                        context: context,
                                        color: Colors.red,
                                      );
                                    } else if (startDate == null) {
                                      showSnackBar(
                                        message:
                                            "PLease enter an Starting Date",
                                        context: context,
                                        color: Colors.red,
                                      );
                                    } else if (endDate == null) {
                                      showSnackBar(
                                        message: "Please enter an Ending Date",
                                        context: context,
                                        color: Colors.red,
                                      );
                                    } else {
                                      await ref
                                          .read(exceededHoursViewModelProvider
                                              .notifier)
                                          .getExceededHours(
                                            startDate: startDate,
                                            endDate: endDate,
                                          );
                                    }
                                  },
                                  child: const Text("Apply"),
                                ),
                                InkWell(
                                  onTap: () {
                                    _showNepaliDatePicker(context, false);
                                  },
                                  child: Icon(
                                    Icons.edit_calendar_outlined,
                                    color: Colors.lightBlue[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (exceededHoursDataView.isLoading) ...{
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        } else if (exceededHoursDataView
                            .exceededHours.isEmpty) ...{
                          const Center(
                            child: Text(
                              "No Data",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                        } else ...{
                          ListView.builder(
                            padding: const EdgeInsets.only(top: 10.0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                exceededHoursDataView.exceededHours.length,
                            itemBuilder: (content, index) {
                              final exceededHoursData =
                                  exceededHoursDataView.exceededHours[index];

                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20.0,
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Material(
                                      borderRadius: BorderRadius.circular(30.0),
                                      elevation: 5.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                          horizontal: 12.0,
                                        ),
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          exceededHoursData
                                                              .employeeName,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 24.0,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  gap,
                                                  Text(
                                                    exceededHoursData.empCode,
                                                    style: const TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  gap,
                                                  Text(
                                                    exceededHoursData
                                                        .employeeLevel,
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  gap,
                                                  Text(
                                                    exceededHoursData
                                                        .employmentType,
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  gap,
                                                  Text(
                                                    exceededHoursData
                                                        .designation,
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  gap,
                                                  Text(
                                                    exceededHoursData
                                                            .exceededHours ??
                                                        'N/A',
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        },
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
