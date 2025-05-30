import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
    // @State message: string = 'Hello World';

    aboutToAppear(): void {
        setTimeout(() => {
            const token = AppStorage.get<number>('aProp');
            if (token === 47) {
                AlertDialog.show({ title: 'picture token', message: token?.toString() })
                router.replaceUrl({ url: "pages/Main/MainPage" })
            } else {
                AlertDialog.show({ title: 'picture token', message: token?.toString() })
                router.replaceUrl({ url: "pages/Login/LoginPage" })
            }
        }, 200)
    }

    build() {
        Column() {
            Text('Loading...')
                .fontSize(20)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#FFFFFF')

        // RelativeContainer() {
        //     Text(this.message)
        //         .id('HelloWorld')
        //         .fontSize($r('app.float.page_text_font_size'))
        //         .fontWeight(FontWeight.Bold)
        //         .alignRules({
        //             center: { anchor: '__container__', align: VerticalAlign.Center },
        //             middle: { anchor: '__container__', align: HorizontalAlign.Center }
        //         })
        //         .onClick(() => {
        //             this.message = 'Welcome';
        //         })
        // }
        // .height('100%')
        // .width('100%')
    }
}