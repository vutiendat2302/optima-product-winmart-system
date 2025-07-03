create table user_store
(
    id       bigint auto_increment comment 'Khóa chính, định danh bản ghi'
        primary key,
    user_id  bigint null comment 'ID người dùng (FK user)',
    store_id bigint null comment 'ID cửa hàng (FK store)',
    constraint user_store_ibfk_1
        foreign key (user_id) references user (id),
    constraint user_store_ibfk_2
        foreign key (store_id) references store (id)
)
    comment 'Gán người dùng vào các cửa hàng (nhiều-mnhiều)';

create index store_id
    on user_store (store_id);

create index user_id
    on user_store (user_id);

