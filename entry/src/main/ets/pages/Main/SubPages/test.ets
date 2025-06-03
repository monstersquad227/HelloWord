// xxx.ets

class SelectTime {
    selectTime: Date = new Date('2020-12-25T08:30:00')

    hours(h: number, m: number) {
        this.selectTime.setHours(h, m)
    }
}

@Entry
@Preview
@Component
struct TimePickerDialogExample {
    @State selectTime: Date = new Date('2023-12-25T08:30:00');

    build() {
        Column() {
            Button('showTimePickerDialog')
                .margin(30)
                .onClick(() => {
                    this.getUIContext().showTimePickerDialog({
                        selected: this.selectTime,
                        onAccept: (value: TimePickerResult) => {
                            // 设置selectTime为按下确定按钮时的时间，这样当弹窗再次弹出时显示选中的为上一次确定的时间
                            // let time = new SelectTime()
                            // if (value.hour && value.minute) {
                            //     time.hours(value.hour, value.minute)
                            // }
                            console.info("TimePickerDialog:onAccept()" + JSON.stringify(value))
                            AlertDialog.show({ title: 'onAccept', message: value.hour + ':' + value.minute })
                        },
                        onCancel: () => {
                            console.info("TimePickerDialog:onCancel()")
                            AlertDialog.show({ title: 'onCancel', message: 'onCancel' })
                        },
                        onChange: (value: TimePickerResult) => {
                            console.info("TimePickerDialog:onChange()" + JSON.stringify(value))
                            AlertDialog.show({ title: 'onChange', message: value.hour + ':' + value.minute })
                        }
                    })
                })
        }.width('100%').margin({ top: 5 })
    }
}