import { router } from '@kit.ArkUI'

@Component
@Entry
struct AnswerOnePages {
    build() {
        Column() {
            Image($r('app.media.right_grey'))
                .width(16)
                .height(16)
                .rotate({ angle: 180 })
                .onClick(() => {
                    router.back()
                })
                .alignSelf(ItemAlign.Start)
                .margin({ left: 20, top: 20, })
            Column() {
                Text('敬请期待')
                    .margin({ top: '100.00vp' })
            }
        }
        .width('100%').height('100%')
    }
}