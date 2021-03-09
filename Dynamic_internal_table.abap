
DATA:     d_ref TYPE REF TO data,
wa_ref TYPE REF TO data,
lt_alv_cat TYPE TABLE OF lvc_s_fcat,
ls_alv_cat LIKE LINE OF lt_alv_cat.

DATA: tab_fieldcat TYPE slis_t_fieldcat_alv,
rec_fieldcat TYPE  slis_fieldcat_alv .

FIELD-SYMBOLS : <dyn_table> TYPE STANDARD TABLE,
                   <dyn_wa> TYPE any,
                   <dyn_field> TYPE any.
                   

*  导出Excel  标题表
TYPES: BEGIN OF typ_fieldnames,
  name TYPE char20,
END OF typ_fieldnames.

DATA: tab_fieldnames TYPE TABLE OF typ_fieldnames,
rec_fieldnames TYPE typ_fieldnames.



ls_alv_cat-fieldname = ls_table-fieldname.
ls_alv_cat-ref_table = p_tabname.
ls_alv_cat-ref_field = ls_table-fieldname.
APPEND ls_alv_cat TO lt_alv_cat.
CLEAR ls_alv_cat.


l_colnum = l_colnum + 1.

rec_fieldcat-fieldname = 'ENDDA'.
rec_fieldcat-col_pos = l_colnum.
rec_fieldcat-seltext_l = rec_fieldcat-seltext_m = rec_fieldcat-seltext_s = '截止日期'.
rec_fieldcat-outputlen = 8.
APPEND rec_fieldcat TO tab_fieldcat.
CLEAR rec_fieldcat.


***		如果下载Excel的话，就需要添加该表
*   获取 导出 Excel 的抬头（标题）
rec_fieldnames-name = ls_table-fieldtext.
APPEND rec_fieldnames TO tab_fieldnames.
CLEAR rec_fieldnames.



*内表创建
CALL METHOD cl_alv_table_create=>create_dynamic_table
EXPORTING
it_fieldcatalog = lt_alv_cat
IMPORTING
ep_table        = d_ref.


ASSIGN d_ref->* TO <dyn_table>.

CREATE DATA wa_ref LIKE LINE OF <dyn_table>.
ASSIGN wa_ref->* TO <dyn_wa>.