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
    announcement_seq.nextval, 'ó�� ��������', '�ֵ�� ȭ����!', sysdate, 0);
    
insert into announcementtable values(
    announcement_seq.nextval, '�ι�° ��������', '�㸮����..', sysdate, 1);
    
insert into announcementtable values(
    announcement_seq.nextval, '����° ��������', '�ϱ�÷�..', sysdate, 0);    
    
commit;


select * from announcementTable order by announcementUp desc, announcementNumber desc ;