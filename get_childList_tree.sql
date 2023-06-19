CREATE DEFINER=`root`@`localhost` 
FUNCTION `getChildList`(rootId VARCHAR(100)) RETURNS varchar(1000) CHARSET utf8
BEGIN
/*
1：pk => id
2：table name => table_name
3：father => parent_id
*/
    DECLARE sTemp VARCHAR(1000);
    DECLARE sTempChd VARCHAR(1000);
 
    SET sTemp = '$';
    SET sTempChd =cast(rootId as CHAR);
 
    WHILE sTempChd is not null DO
        SET sTemp = concat(sTemp,',',sTempChd);
        SELECT group_concat(id) INTO sTempChd FROM table_name where FIND_IN_SET(parent_id,sTempChd)>0;
    END WHILE;
    RETURN sTemp; 
END
