create table rule
(
    id          bigint auto_increment comment 'Khóa chính'
        primary key,
    role_id     bigint       null comment 'ID role (FK role)',
    name        varchar(100) null comment 'Tên quyền',
    description varchar(250) null comment 'Mô tả quyền',
    created_at  datetime     null comment 'Thời gian tạo',
    update_at   datetime     null comment 'Thời gian cập nhật',
    status      tinyint(1)   null comment 'Trạng thái quyền',
    constraint rule_ibfk_1
        foreign key (role_id) references role (id)
)
    comment 'Bảng lưu quyền (rule) của từng role';

create index role_id
    on rule (role_id);

