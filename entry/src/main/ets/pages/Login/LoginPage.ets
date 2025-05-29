import http from '@ohos.net.http';
import { promptAction, router } from '@kit.ArkUI';
import { baseHeader, baseURL } from '../../constant/constant';
import { loginComponentManager, LoginWithHuaweiIDButton } from '@kit.AccountKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';


/**
 * Login page
 */
interface userInfo {
    id: number;
    nickname: string;
    image: string;
    phone_num: string;
    password: string;
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

@Preview
@Entry
@Component
struct LoginPage {
    controller: loginComponentManager.LoginWithHuaweiIDButtonController =
        new loginComponentManager.LoginWithHuaweiIDButtonController()
            .onClickLoginWithHuaweiIDButton((error: BusinessError,
                response: loginComponentManager.HuaweiIDCredential) => {
                if (error) {
                    hilog.error(0x0000, 'testTag',
                        `Failed to onClickLoginWithHuaweiIDButton. Code: ${error.code}, message: ${error.message}`);
                    return;
                }


                if (response) {
                    hilog.info(0x0000, 'testTag', 'Succeeded in getting response.');
                    const authCode = response.authorizationCode;
                    const idToken = response.idToken;
                    // 开发者处理authCode、idToken
                }
            });
    @State account: string = '15056332824';
    @State password: string = '123456';

    build() {
        // container
        Column({ space: '10.00vp' }) {
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
                .height('50.00vp')
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
                .height('50.00vp')
                .maxLength(8)
                .type(InputType.Password)
                .onChange((value: string) => {
                    this.password = value
                })

            Row() {
                Text($r('app.string.forgot_password'))
                    .fontSize('16.00vp')
                    .fontColor('#0F3FFC')
                Blank().width('50%')
                Text($r('app.string.register_account'))
                    .fontSize('16.00vp')
                    .fontColor('#0F3FFC')
            }
            .justifyContent(FlexAlign.SpaceBetween)


            LoginWithHuaweiIDButton({
                params: {
                    // LoginWithHuaweiIDButton支持的样式
                    style: loginComponentManager.Style.BUTTON_RED,
                    // 账号登录按钮在登录过程中展示加载态
                    extraStyle: {
                        buttonStyle: new loginComponentManager.ButtonStyle().loadingStyle({
                            show: true
                        })
                    },
                    // LoginWithHuaweiIDButton的边框圆角半径
                    borderRadius: 24,
                    // LoginWithHuaweiIDButton支持的登录类型
                    loginType: loginComponentManager.LoginType.ID,
                    // LoginWithHuaweiIDButton支持按钮的样式跟随系统深浅色模式切换
                    supportDarkMode: true,
                    // verifyPhoneNumber：如果华为账号用户在过去90天内未进行短信验证，是否拉起Account Kit提供的短信验证码页面
                    verifyPhoneNumber: true
                },
                controller: this.controller
            })
                .width('85%')
                .height('45.00vp')
                .margin({ top: '30.00vp' })
            // Button($r('app.string.huaweiOneClickLogin'))
            //     .width('85%')
            //     .height('45.00vp')
            //     .fontWeight(FontWeight.Medium)
            //     .backgroundColor(Color.Red)
            //     .margin({ top: '30.00vp' })
            // button
            Button($r('app.string.login'), { type: ButtonType.Capsule })
                .width('85%')
                .height('45.00vp')
                .fontSize('18')
                .fontWeight(FontWeight.Medium)
                .backgroundColor($r('sys.color.brand'))
                .onClick(() => {
                    let httpRequest = http.createHttp();
                    let URL = baseURL + '/user/login'
                    let promise = httpRequest.request(URL, {
                        method: http.RequestMethod.POST,
                        connectTimeout: 60000,
                        readTimeout: 60000,
                        header: baseHeader,
                        extraData: {
                            phone_num: this.account,
                            password: this.password
                        },
                        expectDataType: http.HttpDataType.OBJECT
                    });
                    promise.then((data: http.HttpResponse) => {
                        let result = data.result as LoginResponse;
                        if (result.code != 0) {
                            promptAction.showToast({ message: result.message });
                            return;
                        }
                        AppStorage.setOrCreate('token', result.result.token)
                        AppStorage.setOrCreate('nickname', result.result.user.nickname)
                        AppStorage.setOrCreate('user_id', result.result.user.id)
                        AppStorage.setOrCreate('phone', result.result.user.phone_num)
                        router.pushUrl({ url: 'pages/Main/MainPage' })
                    })
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