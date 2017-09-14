window.onload = function() {
    var selectBank = getId("selectBank");
    var txt_SelectBank = getId("txt_SelectBank");
    var txt_BankCard = getId("txt_BankCard");
    var bankPlaceHolder = getId("bankPlaceHolder");
    var bankCardPlaceHolder = getId("bankCardPlaceHolder");

    getId("btn_BankSubmit").onclick = function() {
        console.log("点击立即领取");
    }

    txt_SelectBank.value = selectBank.options[selectBank.selectedIndex].text;
    console.log(selectBank.options[selectBank.selectedIndex].text);
    // selectBank.value = "";
    selectBank.onchange = function(event) {
        console.log(event, selectBank.options);
        txt_SelectBank.value = selectBank.options[selectBank.selectedIndex].text;
    }
    selectBank.onclick = function() {
        bankPlaceHolder.hidden = true;
    }
    txt_SelectBank.onfocus =
        bankPlaceHolder.onclick = function() {
            bankPlaceHolder.hidden = true;
            selectBank.click();
        }
    txt_SelectBank.onblur = function() {
        console.log(this.value);
        bankPlaceHolder.hidden = (this.value == "" ? false : true);
    }
    txt_BankCard.onfocus =
        bankCardPlaceHolder.onclick = function() {
            bankCardPlaceHolder.hidden = true;
        }
    txt_BankCard.onblur = function() {
        console.log(this.value);
        bankCardPlaceHolder.hidden = (this.value == "" ? false : true);
    }
}