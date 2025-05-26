@CustomDialog
export struct AddMedicationRegimenDiaLog {
    @Link textValue: string
    @Link inputValue: string
    controller?: CustomDialogController
    cancel: () => void = () => {
    }
    confirm: () => void = () => {
    }

    build() {
        Column() {
            Text('写备注').fontSize(20).margin({ top: 20, bottom: 20 })

            TextInput({ placeholder: '添加备注', text: this.textValue }).height(60).width('90%')
                .onChange((value: string) => {
                    this.textValue = value
                })

            Flex({ justifyContent: FlexAlign.SpaceAround }) {
                Button('确定')
                    .onClick(() => {
                        this.controller?.close()
                        this.cancel()
                    }).backgroundColor(0xffffff).fontColor(Color.Black)
                Button('取消')
                    .onClick(() => {
                        if (this.controller != undefined) {
                            this.inputValue = this.textValue
                            this.controller.close()
                            this.confirm()
                        }
                    }).backgroundColor(0xffffff).fontColor(Color.Red)
            }
            .margin({ top: 20 })

        }.margin({ bottom: 20 })
    }
}