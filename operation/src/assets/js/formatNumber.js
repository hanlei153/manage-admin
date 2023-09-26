/**
 * 大数字转换 将数字分段显示，每三位用逗号隔开
 * @param value 数字值
 */
export function formatNumber (text) {
	if(text!=null){
        return Number(text.toFixed(2)).toLocaleString()
      }
      console.log('格式化')
}