import hilog from '@ohos.hilog';
import { router } from '@kit.ArkUI';

/**
 * Login page
 */
@Entry
@Component
struct LoginPage {
    @State account: string = '15056332824';
    @State password: string = '123456';

    build() {
        // container
        Column({ space: 10 }) {
            // logo
            Image($r('app.media.logo'))
                .width('80')
                .height('80')
                .margin({
                    top: '80',
                    bottom: '40'
                })
            // input
            TextInput({ placeholder: $r('app.string.account'), text: this.account, })
                .width('85%')
                .height('8%')
                .maxLength(11)
                .type(InputType.Number)
                .margin({
                    top: '60'
                })
            // input
            TextInput({ placeholder: $r('app.string.password'), text: this.password })
                .width('85%')
                .height('8%')
                .maxLength(8)
                .type(InputType.Password)

            // button
            Button($r('app.string.login'), { type: ButtonType.Capsule })
                .width('85%')
                .height('8%')
                .fontSize('18')
                .fontWeight(FontWeight.Medium)
                .backgroundColor($r('sys.color.brand'))
                .margin({
                    top: '48',
                    bottom: '12'
                })
                .onClick(() => {
                    hilog.error(0x0001, "testTag", "%{public}s World %{public}d", "hello", 3);
                    router.pushUrl({ url: 'pages/Main/MainPage' })
                })
        }
        .padding({
            left: '12vp',
            right: '12vp',
            bottom: '24vp'
        })
        .backgroundColor('#F1F3F5')
        .width('100%')
        .height('100%')
    }
}