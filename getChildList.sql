CREATE DEFINER=`root`@`localhost` 
FUNCTION `getChildList`(rootId VARCHAR(100)) RETURNS varchar(1000) CHARSET utf8
BEGIN
/*
1：pk => id
2：table name => course_category
3：father => parentid
*/
    DECLARE sTemp VARCHAR(1000);
    DECLARE sTempChd VARCHAR(1000);
 
    SET sTemp = '$';
    SET sTempChd =cast(rootId as CHAR);
 
    WHILE sTempChd is not null DO
        SET sTemp = concat(sTemp,',',sTempChd);
        SELECT group_concat(id) INTO sTempChd FROM course_category where FIND_IN_SET(parentid,sTempChd)>0;
    END WHILE;
    RETURN sTemp; 
END
