import { createPlanData, CreatePlanResponse } from "../interface/medicinePlan"
import { http } from "@kit.NetworkKit"
import { baseURL } from "../../constant/constant"
import { promptAction } from "@kit.ArkUI"

export function CreatePlan(data: createPlanData) {
    let httpRequest = http.createHttp()
    let URL = baseURL + '/record/' + AppStorage.get('user_id')
    let promise = httpRequest.request(URL, {
        method: http.RequestMethod.POST,
        connectTimeout: 3000,
        readTimeout: 3000,
        header: {
            'Content-Type': 'application/json',
            'token': AppStorage.get('token')
        },
        extraData: data,
        expectDataType: http.HttpDataType.OBJECT
    })
    promise.then((resp: http.HttpResponse) => {
        let result = resp.result as CreatePlanResponse
        if (result.code != 0) {
            promptAction.showToast({ message: result.message });
            return;
        }
        promptAction.showToast({ message: '打卡' + result.message });
    })
}