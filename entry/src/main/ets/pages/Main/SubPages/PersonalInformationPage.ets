import { CustomContentDialog, promptAction, router } from '@kit.ArkUI';
import { http } from '@kit.NetworkKit';
import { baseURL } from '../../../constant/constant';
import { parseJSON } from '../ContentTwoPage';

const ITEM_HEIGHT = '30.00vp'
const ITEM_WIDTH = '80%'

interface UpdateResponse {
    code: number,
    message: string,
    result: number
}

@Component
@Preview
@Entry
struct PersonalInformationPage {
    @StorageProp('nickname') nickname: string = AppStorage.get('nickname') ?? '默认昵称';
    @StorageProp('phone') phone: string = AppStorage.get('phone') ?? '18888888888';
    @State inputText: string = '';
    @State type: string = '';
    dialogController: CustomDialogController = new CustomDialogController({
        builder: CustomContentDialog({
            primaryTitle: '修改',
            contentBuilder: () => {
                this.buildContent();
            },
            buttons: [
                {
                    value: '确定',
                    buttonStyle: ButtonStyleMode.TEXTUAL,
                    action: () => {
                        if (this.type === 'nickname') {
                            let httpRequest = http.createHttp()
                            let URL = baseURL + '/user/' + AppStorage.get('user_id') + '/nickname'
                            let promise = httpRequest.request(URL, {
                                method: http.RequestMethod.PUT,
                                header: {
                                    'Content-Type': 'application/json',
                                    'token': AppStorage.get('token')
                                },
                                extraData: {
                                    nickname: this.inputText
                                },
                                expectDataType: http.HttpDataType.OBJECT
                            })
                            promise.then((data: http.HttpResponse) => {
                                let response = parseJSON<UpdateResponse>(data.result.toString())
                                if (response.code !== 0) {
                                    promptAction.showToast({ message: response.message });
                                    return;
                                }
                                //     AppStorage.setOrCreate('nickname', this.inputText)
                                //     this.nickname = `${this.inputText}`
                                //     // this.dialogController.close()
                                //     promptAction.showToast({ message: AppStorage.get('nickname') })
                            })
                            AppStorage.setOrCreate('nickname', this.inputText)
                            this.nickname = this.inputText // 触发更新
                            // promptAction.showToast({ message: AppStorage.get('nickname') })
                        }
                        if (this.type === 'phone') {
                            let httpRequest = http.createHttp()
                            let URL = baseURL + '/user/' + AppStorage.get('user_id') + '/phone'
                            let promise = httpRequest.request(URL, {
                                method: http.RequestMethod.PUT,
                                header: {
                                    'Content-Type': 'application/json',
                                    'token': AppStorage.get('token')
                                },
                                extraData: {
                                    phone_num: this.inputText
                                },
                                expectDataType: http.HttpDataType.OBJECT
                            })
                            promise.then((data: http.HttpResponse) => {
                                let response = parseJSON<UpdateResponse>(data.result.toString())
                                if (response.code !== 0 || data.responseCode !== 200) {
                                    promptAction.showToast({ message: response.message });
                                    return;
                                }
                            })
                            AppStorage.setOrCreate('phone', this.inputText)
                            this.phone = this.inputText
                            // promptAction.showToast({ message: AppStorage.get('phone') })
                        }
                    }
                },
                {
                    value: '取消',
                    buttonStyle: ButtonStyleMode.TEXTUAL,
                    role: ButtonRole.ERROR
                }
            ],
        }),
    });

    @Builder
    buildContent(): void {
        Column() {
            TextInput({ text: this.inputText }).onChange((value: string) => {
                this.inputText = value
            })
        }
        .width('100%')
    }

    build() {
        Column() {
            // 返回按钮
            Image($r('app.media.right_grey'))
                .width(16)
                .height(16)
                .rotate({ angle: 180 })
                .onClick(() => {
                    router.back()
                })
                .alignSelf(ItemAlign.Start)
                .margin({ left: 20, top: 20 })

            Column({ space: '20.00vp' }) {
                Row() {
                    Text('头像')
                    Blank().flexGrow(1)
                    Image($r('app.media.circle'))
                        .width('30.00vp')
                        .height('30.00vp')
                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width(ITEM_WIDTH)
                .height(ITEM_HEIGHT)

                Row() {
                    Text('昵称').height(ITEM_HEIGHT)
                    Blank().flexGrow(1)
                    Text(this.nickname)
                        .onClick(() => {
                            this.inputText = this.nickname
                            this.type = 'nickname'
                            this.dialogController.open()
                        })
                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width(ITEM_WIDTH)
                .height(ITEM_HEIGHT)


                Row() {
                    Text('手机号').height(ITEM_HEIGHT)
                    Blank().flexGrow(1)
                    Text(this.phone)
                        .onClick(() => {
                            this.inputText = this.phone
                            this.type = 'phone'
                            this.dialogController.open()
                        })
                }
                .justifyContent(FlexAlign.SpaceBetween).width(ITEM_WIDTH).height(ITEM_HEIGHT)
                .onClick(() => {
                    this.dialogController.open()
                })
            }
            .margin({ top: '20.00vp' })
        }
        .width('100%')
        .height('100%')
    }
}