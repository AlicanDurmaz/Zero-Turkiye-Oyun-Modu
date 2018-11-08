stock convertNumber(iValue, iDelim[2] = ".", szNum[15] = "", iSize = sizeof(szNum)) {

	format(szNum, iSize, "%d", iValue);



	for(new i = strlen(szNum) - 3; i > 0; i -= 3) {

		strins(szNum, iDelim, i, iSize);

	}

	if(iValue < 0) {

		strins(szNum, "-",0, iSize);

	}
/*


printf("%s", convertNumber(1246645455, .iDelim = "_")); // 1_246_645_455

printf("%s", convertNumber(-145455, .iDelim = ".")); // -145.455

printf("%s", convertNumber(-94411254, .iDelim = ",")); // -94,411,254
*/
	return szNum;

}

