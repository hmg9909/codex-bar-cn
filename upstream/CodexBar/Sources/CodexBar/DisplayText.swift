enum DisplayText {
    static func zh(status text: String) -> String {
        switch text {
        case "Partial System Degradation":
            "部分服务降级"
        case "Operational":
            "正常运行"
        case "Partial outage":
            "部分中断"
        case "Major outage":
            "重大中断"
        case "Critical issue":
            "严重问题"
        case "Maintenance":
            "维护中"
        case "Status unknown":
            "状态未知"
        default:
            text
        }
    }
}
