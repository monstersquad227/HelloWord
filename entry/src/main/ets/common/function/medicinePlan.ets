import { createPlanData, CreatePlanResponse, ListPlanData, ListPlanResponse } from "../interface/medicinePlan"
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

export async function ListPlan(): Promise<ListPlanData[]> {
    let httpRequest = http.createHttp();
    let URL = baseURL + '/plan' + '/' + AppStorage.get('user_id');

    try {
        let resp = await httpRequest.request(URL, {
            method: http.RequestMethod.GET,
            connectTimeout: 3000,
            readTimeout: 3000,
            header: {
                'Content-Type': 'application/json',
                'token': AppStorage.get('token')
            },
        });


        let res: ListPlanResponse = JSON.parse(resp.result as string);

        if (res.code !== 0) {
            promptAction.showToast({ message: res.message });
            return [];
        }
        return res.result;

    } catch (error) {
        promptAction.showToast({ message: 'Network error' });
        return [];
    }
}