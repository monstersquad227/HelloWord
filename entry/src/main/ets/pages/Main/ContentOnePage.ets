// import { AddMedicationRegimenDiaLog } from './DiaLog/AddMedicationRegimenDiaLog';
// import { promptAction, router } from '@kit.ArkUI';
// import { CalendarPage } from './CalendarPage/CalendarPage';
// import { http } from '@kit.NetworkKit';
// import { baseURL } from '../../constant/constant';
// import { createPlanData, planResponse, planResult } from '../../common/interface/medicinePlan';
// import { CreatePlan } from '../../common/function/medicinePlan';
// import { parseJSON, translateMedicineTime } from '../../common/function/medicineCourse';
//
//
// @Preview
// @Entry
// @Component
// export struct ContentOnePage {
//     @State textValue: string = '';
//     @State inputValue: string = '点击添加备注';
//     @State planData: planResult[] = [];
//     @State isRefresh: boolean = false;
//     dialogController: CustomDialogController = new CustomDialogController({
//         builder: AddMedicationRegimenDiaLog({
//             textValue: $textValue,
//             inputValue: $inputValue,
//             cancel: this.onCancel,
//             confirm: this.onConfirm
//         }),
//         autoCancel: true,
//         alignment: DialogAlignment.Bottom,
//         offset: { dx: 0, dy: -20 }
//     });
//
//     onCancel() {
//         console.info('取消（删除）备注')
//     };
//
//     onConfirm() {
//         console.info('确认保存备注: ', this.inputValue)
//     };
//
//     aboutToAppear(): void {
//         this.getPlanList();
//     };
//
//     build() {
//         Column({ space: 20 }) {
//             Refresh({
//                 refreshing: this.isRefresh
//             }) {
//                 Column() {
//                     Row() {
//                         CalendarPage()
//                     }.height('50%')
//
//                     if (this.planData.length > 0) {
//                         Scroll() {
//                             Column() {
//                                 // Refresh({
//                                 //     refreshing: this.isRefresh
//                                 // }) {
//                                 Column({ space: '20.00vp' }) {
//                                     ForEach(this.planData, (item: planResult) => {
//                                         Row() {
//                                             Column({ space: '20.00vp' }) {
//                                                 Text(item.medicine_name + ' ' + item.amount + ' ' + item.type)
//                                                     .fontWeight(FontWeight.Bold)
//                                                     .margin({ top: '10.00vp' })
//                                                 Text(item.plan_time + ' ' + translateMedicineTime(item.medicine_timing))
//                                                     .margin({ bottom: '10.00vp' })
//                                             }
//                                             .alignItems(HorizontalAlign.Start)
//                                             .margin({ left: '20.00vp' })
//
//                                             // Blank().grayscale(1)
//
//                                             Button('打卡')
//                                                 .width('30%')
//                                                 .height('25%')
//                                                 .type(ButtonType.Normal)
//                                                 .onClick(() => {
//                                                     let body: createPlanData = {
//                                                         medicine_name: item.medicine_name,
//                                                         actual_time: this.generateActualTime(),
//                                                         memo: '',
//                                                         status: this.compareTime(item.plan_time)
//                                                     }
//                                                     CreatePlan(body)
//                                                     //
//                                                     // AlertDialog.show({
//                                                     //     title: 'record',
//                                                     //     message: JSON.stringify(body)
//                                                     // })
//                                                 })
//                                                 .margin({ right: '20.00vp' })
//                                         }
//                                         .width('85%')
//                                         .justifyContent(FlexAlign.SpaceBetween)
//                                         .border({ width: 1, color: '#cccccc', radius: 8 })
//                                     })
//                                 }
//
//                             }
//                         }.height('35%')
//                     } else {
//                         Column({ space: '20.00vp' }) {
//                             Image($r('app.media.background'))
//                                 .width('80')
//                                 .height('80')
//                             Text($r('app.string.NoNeedToPunchInToday'))
//                             Button($r('app.string.AddMedicationRegimen'))
//                                 .width('70%')
//                                 .height('60')
//                                 .type(ButtonType.Normal)
//                                 .borderRadius('16')
//                                 .fontSize('16')
//                                 .onClick(() => {
//                                     router.pushUrl({ url: 'pages/Main/SubPages/MedicineCourse' })
//                                 })
//                         }
//                     }
//
//                     Button($r('app.string.WriteANote'))
//                         .width('50%')
//                         .height('60')
//                         .backgroundColor('#F4F7FF')
//                         .fontColor('#6599F2')
//                         .fontSize('16')
//                         .onClick(() => {
//                             this.dialogController.open()
//                             console.log('写备注点击事件')
//                         })
//                         .margin({ top: '20.00vp' })
//                 }
//             }
//             .onRefreshing(() => {
//                 this.isRefresh = true
//                 this.getPlanList()
//                 setTimeout(() => {
//                     this.isRefresh = false
//                 }, 1000)
//             })
//             .refreshOffset(100)
//         }
//         .width('100%')
//         .height('100%')
//     }
//
//     private getPlanList() {
//         let httpRequest = http.createHttp()
//         let URL = baseURL + '/plan' + '/' + AppStorage.get('user_id')
//         let promise = httpRequest.request(URL, {
//             method: http.RequestMethod.GET,
//             header: {
//                 'Content-Type': 'application/json',
//                 'token': AppStorage.get('token')
//             }
//         })
//         promise.then((data: http.HttpResponse) => {
//             let response = parseJSON<planResponse>(data.result.toString())
//             if (response.code !== 0) {
//                 promptAction.showToast({ message: response.message });
//                 return;
//             }
//             this.planData = response.result
//         })
//     }
//
//     private generateActualTime(): string {
//         let date = new Date()
//         let yearStr = date.getFullYear().toString()
//         let year = String(yearStr).padStart(2, '0')
//         let monthStr = date.getMonth().toString()
//         let month = String(monthStr).padStart(2, '0')
//         let dayStr = date.getDay().toString()
//         let day = String(dayStr).padStart(2, '0')
//         let hourStr = date.getHours().toString()
//         let hour = String(hourStr).padStart(2, '0')
//
//         let minuteStr = date.getMinutes().toString()
//         let minute = String(minuteStr).padStart(2, '0')
//         return `${year}-${month}-${day} ${hour}:${minute}:00`
//     }
//
//     private compareTime(planTime: string): number {
//         let platTimes = planTime.split(':');
//         const planHour = parseInt(platTimes[0], 10);
//         const planMinute = parseInt(platTimes[1], 10);
//
//         // 计划时间的总分钟数
//         const planTotalMinutes = planHour * 60 + planMinute;
//
//         // 当前时间
//         let now = new Date();
//         let currentTotalMinutes = now.getHours() * 60 + now.getMinutes();
//         let diff = Math.abs(planTotalMinutes - currentTotalMinutes);
//         return diff > 15 ? 1 : 0;
//     }
// }
//
