--===============================
-- upmu 계정
--===============================
select * from user_tables; --전체 테이블 조회
select * from cols; --전체 테이블 컬럼 조회

-- board 테이블생성
create table board(
    no number,
    title varchar2(500),
    emp_no number,
    content varchar2(2000),
    reg_date date default sysdate,
    read_count number default 0,
    constraint pk_board_no primary key(no),
    constraint fk_board_emp_no foreign key(emp_no) 
            references employee(emp_no) on delete set null
);
-- board 테이블조회
select * from board;

-- attachment테이블 생성
create table attachment(
    no number,
    board_no number not null,
    original_filename varchar2(256) not null,
    renamed_filename varchar2(256) not null,
    upload_date date default sysdate,
    download_count number default 0,
    status char(1) default 'Y',
    constraint pk_attachment_no primary key(no),
    constraint fk_attachment_board_no foreign key(board_no)
        references board(no) on delete cascade,
    constraint ck_attachment_status check(status in ('Y', 'N'))
);
-- attachment 테이블조회
select * from attachment;

--seq생성
create sequence seq_board_no;
create sequence seq_attachment_no;

select * from board order by no desc;

Insert into UPMU.BOARD (no,title,emp_no,content,reg_date,read_count) values (SEQ_BOARD_NO.nextval,'테스트용 게시판 1번쨰 글','1','안녕하세요 신입사원 홍길동입니다.',to_date('20/12/02','RR/MM/DD'),0);
insert into attachment values(seq_attachment_no.nextval, 1, 'test.jpg', '20210708_220059_123.jpg', default, default, default);
commit;

		select
			b.*,
			(select count(*) from attachment where no = b.no) attach_count			
		from 
			board b
		order by
			no desc;











