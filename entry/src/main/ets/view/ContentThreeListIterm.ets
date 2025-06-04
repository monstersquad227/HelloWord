import { recordListResponseResultV2Contents } from '../common/interface/medicinePlanRecord'

@Component
export struct ContentThreeListIterm {
    @Prop date: string
    @Prop contents: recordListResponseResultV2Contents[]
    @Prop content: string
    @Prop status: number

    build() {
        Column() {
            Row() {
                Text(this.cuttingDate(this.date))
                    .fontSize('18')
                    .fontWeight(FontWeight.Medium)
                    .backgroundColor($r('app.media.background'))
                Image($r('app.media.right_grey'))
                    .width('16')
                    .height('16')
            }
            .border({ width: 1, color: '#ff73a2f5', radius: { topLeft: '8.00vp', topRight: '8.00vp' } })
            .width('100%')
            .height('5%')
            .backgroundColor('#6498f1')
            .padding('5')
            .justifyContent(FlexAlign.SpaceBetween)

            ForEach(this.contents, (item: recordListResponseResultV2Contents) => {
                Row() {
                    Text(item.medicine_name)
                        .fontSize(14)
                        .fontColor('#888888')
                        .margin({ top: 4 })
                    Blank()
                    Text(this.translateStatus(item.status))
                        .fontSize(14)
                        .fontColor(item.status === 1 ? '#FF0000' : '#0000FF')
                        .margin({ top: 4 })
                }
                .width('100%')
                .padding('10')
                .justifyContent(FlexAlign.SpaceBetween)
            })
            // Row() {
            //     Text(this.content)
            //         .fontSize(14)
            //         .fontColor('#888888')
            //         .margin({ top: 4 })
            //     Blank()
            //     Text(this.translateStatus(this.status))
            //         .fontSize(14)
            //         .fontColor(this.status === 1 ? '#FF0000' : '#0000FF')
            //         .margin({ top: 4 })
            // }
            // .width('100%')
            // .padding('10')
            // .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .margin({ bottom: 15 })
    }

    private cuttingDate(date: string): string {
        let dateTimes = date.split(' ');
        if (dateTimes.length !== 2) {
            return date;
        }
        return dateTimes[0];
    }

    private translateStatus(value: number): string {
        if (value === 1) {
            return '异常'
        } else {
            return '正常'
        }
    }
}