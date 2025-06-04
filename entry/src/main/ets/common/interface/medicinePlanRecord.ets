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