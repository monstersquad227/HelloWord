import { translateMedicineTime } from '../common/function/medicineCourse';
import { createPlanData } from '../common/interface/medicinePlan';

@Component
export struct ContentOnePlanListIterm {
    @Prop medicine_name: string = '';
    @Prop amount: number = 0;
    @Prop type: string = '';
    @Prop plan_time: string = '';
    @Prop medicine_timing: number = 0;
    @Prop plan_id: number = 0
    @Prop is_checked: number = 0

    build() {
        Column() {
            Row() {
                Column({ space: '20.00vp' }) {
                    Text(this.medicine_name + ' ' + this.amount + ' ' + this.type)
                        .fontWeight(FontWeight.Bold)
                        .alignSelf(ItemAlign.Start)
                    Text(this.plan_time + ' ' + translateMedicineTime(this.medicine_timing))
                        .alignSelf(ItemAlign.Start)
                }
                .padding('10.00vp')

                Blank().layoutWeight(1)

                Button(this.is_checked === 0 ? '打卡' :
                    '撤销打卡')// .width(this.is_checked === 0 ? '60.00vp' : '120.00vp')
                    .width('90.00vp')
                    .height('60.00vp')
                    .backgroundColor(this.is_checked === 0 ? null : Color.Grey)
                    .type(ButtonType.Normal)
                    .border({ radius: '16.00vp' })
                    .onClick(() => {
                        let body: createPlanData = {
                            plan_id: this.plan_id,
                            medicine_name: this.medicine_name,
                            actual_time: this.generateActualTime(),
                            memo: '',
                            status: this.compareTime(this.plan_time)
                        }
                        AlertDialog.show({ title: 'body', message: JSON.stringify(body) })
                        // CreatePlan(body)
                    })
                    .margin({ right: '20.00vp' })
            }
        }
    }

    private generateActualTime(): string {
        let date = new Date()
        let yearStr = date.getFullYear().toString()
        let year = String(yearStr).padStart(2, '0')
        let monthStr = date.getMonth().toString()
        let month = String(monthStr).padStart(2, '0')
        let dayStr = date.getDay().toString()
        let day = String(dayStr).padStart(2, '0')
        let hourStr = date.getHours().toString()
        let hour = String(hourStr).padStart(2, '0')

        let minuteStr = date.getMinutes().toString()
        let minute = String(minuteStr).padStart(2, '0')
        return `${year}-${month}-${day} ${hour}:${minute}:00`
    }

    private compareTime(planTime: string): number {
        let platTimes = planTime.split(':');
        const planHour = parseInt(platTimes[0], 10);
        const planMinute = parseInt(platTimes[1], 10);

        // 计划时间的总分钟数
        const planTotalMinutes = planHour * 60 + planMinute;

        // 当前时间
        let now = new Date();
        let currentTotalMinutes = now.getHours() * 60 + now.getMinutes();
        let diff = Math.abs(planTotalMinutes - currentTotalMinutes);
        return diff > 15 ? 1 : 0;
    }
}