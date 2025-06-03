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