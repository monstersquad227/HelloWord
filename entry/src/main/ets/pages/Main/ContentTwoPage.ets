import { router } from '@kit.ArkUI'

@Component
export struct ContentTwoPage {
    build() {
        Column({ space: 20 }) {
            Image($r('app.media.background'))
                .width('100%')
                .height('80%')

            Button($r('app.string.AddMedicationRegimen'))
                .width('90%')
                .height('60')
                .type(ButtonType.Normal)
                .borderRadius('16')
                .fontSize('16')
                .onClick(() => {
                    router.pushUrl({ url: 'pages/Main/SubPages/AddMedicationRegimenPage' })
                })
        }
        .width('100%')
        .height('100%')
    }
}