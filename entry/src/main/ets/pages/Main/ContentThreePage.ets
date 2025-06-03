import { recordList } from '../../common/function/medicinePlanRecord';
import { recordListResponseResult } from '../../common/interface/medicinePlanRecord';
import { ContentThreeListIterm } from '../../view/ContentThreeListIterm';

@Preview
@Component
export struct ContentThreePage {
    @State recordIterm: Array<recordListResponseResult> = [];
    @State isRefreshing: boolean = false;

    async aboutToAppear(): Promise<void> {
        this.recordIterm = await recordList()
    }

    build() {
        Column() {
            Refresh({
                refreshing: this.isRefreshing,
                promptText: '刷新中......'
            }) {
                if (this.recordIterm.length === 0) {
                    Column() {
                        Text('还有没打卡记录哦')
                    }
                    .width('100%')
                    .height('100%')
                    .justifyContent(FlexAlign.Center)
                    .align(Alignment.Center)
                } else {
                    List() {
                        ForEach(this.recordIterm, (item: recordListResponseResult) => {
                            ListItem() {
                                ContentThreeListIterm({
                                    date: item.actual_time,
                                    content: item.medicine_name,
                                    status: item.status
                                })
                            }
                        })
                    }
                    .padding('20.00vp')
                    .alignListItem(ListItemAlign.Center)
                    .scrollBar(BarState.Auto)
                }

            }
            .layoutWeight(1)
            .onStateChange(async () => {
                this.isRefreshing = true
                this.recordIterm = await recordList()
                setTimeout(() => {
                    this.isRefreshing = false
                }, 1000)
            })
            .refreshOffset(100)

        }
        .width('100%')
        .height('100%')
    }
}