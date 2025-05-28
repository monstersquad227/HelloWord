const basePATH = '/medicine'

interface header {
    'Content-Type': string;
}

export const baseHeader: header = {
    'Content-Type': 'application/json'
}

export const baseURL = 'http://10.11.11.56:8080' + basePATH