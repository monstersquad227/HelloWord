import { router } from '@kit.ArkUI'

@Preview
@Entry
@Component
struct PersonalInformationPage {
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

            Row({ space: 200 }) {
                Text('头像')
                Image($r('app.media.circle'))
                    .width('30')
                    .height('30')
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)


            Row({ space: 115 }) {
                Text('昵称')
                Text('用户54979976')
                    .width('110')
                    .height('30')
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height('100%')
    }
}