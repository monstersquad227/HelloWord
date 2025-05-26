@Component
export struct ContentThreeIterm {
    @Prop date: string
    @Prop content: string

    build() {
        Column() {
            Row() {
                Text(this.date)
                    .fontSize('18')
                    .fontWeight(FontWeight.Medium)
                    .backgroundColor($r('app.media.background'))
                Image($r('app.media.right_grey'))
                    .width('16')
                    .height('16')
            }
            .border({ width: 1, color: '#ff73a2f5', radius: '8' })
            .width('100%')
            .height('5%')
            .backgroundColor('#6498f1')
            .padding('5')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
                Text(this.content)
                    .fontSize(14)
                    .fontColor('#888888')
                    .margin({ top: 4 })
            }
            .width('100%')
            .padding('10')
            .justifyContent(FlexAlign.Start)

        }
        .width('100%')
        .margin({ bottom: 15 })
    }
}