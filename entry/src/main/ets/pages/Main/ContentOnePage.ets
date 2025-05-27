import { AddMedicationRegimenDiaLog } from './DiaLog/AddMedicationRegimenDiaLog';
import { router } from '@kit.ArkUI';
import { CalendarPage } from './CalendarPage/CalendarPage';

@Entry
@Component
export struct ContentOnePage {
    @State textValue: string = ''
    @State inputValue: string = '点击添加备注'
    dialogController: CustomDialogController = new CustomDialogController({
        builder: AddMedicationRegimenDiaLog({
            textValue: $textValue,
            inputValue: $inputValue,
            cancel: this.onCancel,
            confirm: this.onConfirm
        }),
        autoCancel: true,
        alignment: DialogAlignment.Bottom,
        offset: { dx: 0, dy: -20 }
    })

    onCancel() {
        console.info('取消（删除）备注')
    }

    onConfirm() {
        console.info('确认保存备注: ', this.inputValue)
    }

    build() {
        Column({ space: 20 }) {
            Row() {
                CalendarPage()
            }.height('50%')

            // .backgroundImage($r('app.media.logo'))
            // .backgroundImageSize({ width: '100%', height: '100%' }) // 拉伸背景图至整个区域
            // .backgroundImagePosition({ x: 0, y: 0 }) // 左上角对齐

            // Image($r('app.media.background'))
            //     .width('100%')
            //     .height('50%')

            Image($r('app.media.background'))
                .width('80')
                .height('80')

            Text($r('app.string.NoNeedToPunchInToday'))

            Button($r('app.string.AddMedicationRegimen'))
                .width('70%')
                .height('60')
                .type(ButtonType.Normal)
                .borderRadius('16')
                .fontSize('16')
                .onClick(() => {
                    router.pushUrl({ url: 'pages/Main/SubPages/AddMedicationRegimenPage' })
                })

            Button($r('app.string.WriteANote'))
                .width('50%')
                .height('60')
                .backgroundColor('#F4F7FF')
                .fontColor('#6599F2')
                .fontSize('16')
                .onClick(() => {
                    this.dialogController.open()
                    console.log('写备注点击事件')
                })
        }
        .width('100%')
        .height('100%')
    }
}