CREATE OR REPLACE PROCEDURE add_comment ( model_id IN NUMBER, userId IN NUMBER, text IN VARCHAR2 )
IS 
	comment_id NUMBER;
BEGIN 
	SELECT NVL(MAX( COMMENT_ID ),0)+1 INTO comment_id
	FROM COMMENTS;
	
	DBMS_OUTPUT.PUT_LINE( comment_id );
	
	INSERT INTO comments ( COMMENT_TEXT, MODEL_COLOR_ID, CUSTOMER_ID, COMMENT_ID )
	VALUES ( text, model_id, userId, comment_id );
	
EXCEPTION 
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE ( 'ERROR' );
END;