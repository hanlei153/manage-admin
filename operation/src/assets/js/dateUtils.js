// 格式化日期为 "YYYY-MM-DD"
export function formatDate(date) {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
  
  // 获取当前月份的第一天
  export function getFirstDayOfMonth() {
    const currentDate = new Date();
    return new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
  }
  
  // 获取当前月份的最后一天
  export function getLastDayOfMonth() {
    const currentDate = new Date();
    return new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
  }

  // 日期字符串转数字日期
  export function convertDateFormat(originalDateStr) {
    // 在日期字符串中明确指定时区为UTC
    const utcDateStr = originalDateStr + " UTC";
    const originalDate = new Date(utcDateStr);
  
    const year = originalDate.getUTCFullYear();
    const month = String(originalDate.getUTCMonth() + 1).padStart(2, '0');
    const day = String(originalDate.getUTCDate()).padStart(2, '0');
    const hours = String(originalDate.getUTCHours()).padStart(2, '0');
    const minutes = String(originalDate.getUTCMinutes()).padStart(2, '0');
    const seconds = String(originalDate.getUTCSeconds()).padStart(2, '0');
    
    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
  }
  