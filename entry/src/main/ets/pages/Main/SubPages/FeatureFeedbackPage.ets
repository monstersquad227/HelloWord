import { router } from '@kit.ArkUI'

@Component
@Entry
struct FeatureFeedbackPage {
    build() {
        Column() {
            Image($r('app.media.right_grey'))
                .width('16')
                .height('16')
                .onClick(() => {
                    router.back()
                })
            Text('干中学')
                .margin({ top: '50%' })
        }
        .height('100%')
        .width('100%')
    }
}