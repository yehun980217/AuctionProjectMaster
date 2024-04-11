drop table announcementTable;
drop sequence announcement_seq;

create table announcementTable(
    announcementNumber number,
    announcementTitle varchar2(100),
    announcementContent varchar2(2000),
    announcementDate date,
    announcementUp  number default 0
);

create sequence announcement_seq;

insert into announcementtable values(
    announcement_seq.nextval, '처음 공지사항', '애들아 화이팅!', sysdate, 0);
    
insert into announcementtable values(
    announcement_seq.nextval, '두번째 공지사항', '허리아파..', sysdate, 1);
    
insert into announcementtable values(
    announcement_seq.nextval, '세번째 공지사항', '하기시렁..', sysdate, 0);    
    
commit;


select * from announcementTable order by announcementUp desc, announcementNumber desc ;