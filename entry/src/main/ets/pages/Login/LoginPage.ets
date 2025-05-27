import http from '@ohos.net.http';
import { promptAction, router } from '@kit.ArkUI';


/**
 * Login page
 */
interface userInfo {
    nickname: string;
    phone_num: string;
}
interface result {
    token: string;
    user: userInfo;
}

interface LoginResponse {
    code: number;
    message: string;
    result: result;
}

@Entry
@Component
struct LoginPage {
    @State account: string = '';
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
                .onChange((value: string) => {
                    this.account = value
                })
            // input
            TextInput({ placeholder: $r('app.string.password'), text: this.password })
                .width('85%')
                .height('8%')
                .maxLength(8)
                .type(InputType.Password)
                .onChange((value: string) => {
                    this.password = value
                })

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
                    let  httpRequest = http.createHttp();
                    let URL = "http://192.168.1.8:8080/medicine/user/login"
                    let promise = httpRequest.request(URL, {
                        method: http.RequestMethod.POST,
                        connectTimeout: 60000,
                        readTimeout: 60000,
                        header: {
                            "Content-Type": "application/json"
                        },
                        extraData: {
                            phone_num: this.account,
                            password: this.password
                        },
                        expectDataType: http.HttpDataType.OBJECT
                    });
                    promise.then((data:http.HttpResponse) => {
                        let result = data.result as LoginResponse; // 显式声明类型（可选）
                        if (result.code != 0) {
                            promptAction.showToast({ message: result.message });
                            return;
                        }
                        AppStorage.setOrCreate('nickname', result.result.user.nickname)
                        router.pushUrl({ url: 'pages/Main/MainPage' })
                    })
                    // httpRequest.request("http://192.168.1.8:8080/medicine/user/login", {
                    //         method: http.RequestMethod.POST,
                    //         header: {
                    //             "Content-Type": "application/json"
                    //         },
                    //         extraData: {
                    //             phone_num: this.account,
                    //             password: this.password
                    //         },
                    //         readTimeout: 3000,
                    //         connectTimeout: 3000
                    //     }, (err, data) => {
                    //         if (err) {
                    //             promptAction.showToast({ message: '失败: ' + JSON.stringify(err)})
                    //             // AlertDialog.show({ title: '失败', message: JSON.stringify(err) });
                    //             return;
                    //         }
                    //         // let parsed: ApiResponse;
                    //         // parsed = JSON.parse(data.result as string) as ApiResponse;
                    //         // prompt.showToast({ message: '登录成功: ' + parsed.result.user.nickname });
                    //         // AppStorage.setOrCreate('nickname', parsed.result.user.nickname)
                    //         AppStorage.setOrCreate('nickname', '叶宁')
                    //         promptAction.showToast({ message: data.result.toString()})
                    //         // AlertDialog.show({ message: data.result.toString() });
                    //         router.pushUrl({ url: 'pages/Main/MainPage' })
                    //         // JSON.stringify(data)
                    //         // AlertDialog.show({ title: '成功', message: data.result.token });
                    //     }
                    // )
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