export interface recordListResponseResult {
    id: number,
    medicine_name: string,
    actual_time: string,
    memo?: string,
    status: number
}

export interface recordListResponse {
    code: number,
    message: string,
    result: recordListResponseResult[]
}

export interface recordListResponseV2 {
    code: number,
    message: string,
    result: recordListResponseResultV2[]
}

export interface recordListResponseResultV2 {
    actual_time: string,
    contents: recordListResponseResultV2Contents[]
}

export interface recordListResponseResultV2Contents {
    id: number,
    medicine_name: string,
    memo?: string,
    status: number
}

export interface recordPutResponse {
    code: number,
    message: string,
    result: number
}

export interface recordPutData {
    actual_time: string,
    is_checked: number,
    plan_id: number,
}