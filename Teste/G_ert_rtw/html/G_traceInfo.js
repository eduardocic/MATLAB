function RTW_Sid2UrlHash() {
	this.urlHashMap = new Array();
	/* <S1>/Gain */
	this.urlHashMap["Simulacao:13"] = "G.c:33&G.h:50&G_data.c:22";
	/* <S1>/Sum */
	this.urlHashMap["Simulacao:4"] = "G.c:36";
	this.getUrlHash = function(sid) { return this.urlHashMap[sid];}
}
	RTW_Sid2UrlHash.instance = new RTW_Sid2UrlHash();
