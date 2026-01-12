create database SocialLab ;
use SocialLab;

create table posts(
	post_id  int primary key auto_increment,
    content text not null,
    author varchar(100) not null,
    likes_count int not null default(0)
);

insert into posts (content, author, likes_count) values
('Bài viết đầu tiên về SQL', 'Alice', 5),
('Học MySQL cùng ChatGPT', 'Bob', 10),
('Tạo thủ tục lưu trữ trong MySQL', 'Charlie', 3),
('Cách sử dụng JOIN hiệu quả', 'David', 7),
('Phân trang với LIMIT và OFFSET', 'Eve', 2),
('Tìm kiếm dữ liệu với LIKE', 'Frank', 8),
('CASE WHEN vs IF trong SQL', 'Grace', 4),
('Hướng dẫn trigger trong MySQL', 'Heidi', 1),
('Quản lý transaction trong MySQL', 'Ivan', 6),
('Index giúp tăng tốc truy vấn', 'Judy', 9),
('Cấu trúc bảng và khóa chính', 'Karl', 0),
('Sử dụng VIEW trong MySQL', 'Laura', 3),
('Stored procedure cơ bản', 'Mallory', 2),
('Backup và restore dữ liệu', 'Niaj', 5),
('Bảo mật MySQL với quyền truy cập', 'Olivia', 7);

-- Task 1 (CREATE): Viết thủ tục sp_CreatePost để thêm bài viết mới.
-- Sử dụng tham số IN cho content và author.
-- Sử dụng tham số OUT để trả về post_id của bài viết vừa tạo.
DELIMITER //
create procedure sp_CreatePost(content_in varchar(100), author_in varchar(100), out post_id_out int)
begin
    insert into posts(content, author) 
    values (content_in, author_in);
    set post_id_out = last_insert_id();
end //
DELIMITER ;

call sp_CreatePost('Hom nay di hoc khong vui', 'abc', @rs);
select @rs;
call sp_CreatePost('Hellooo', 'abc', @rs);
select @rs;
call sp_CreatePost('hello ngay moi', 'abc', @rs);
select @rs;

-- Task 2 (READ & SEARCH): Viết thủ tục sp_SearchPost để tìm kiếm.
-- Sử dụng tham số IN là từ khóa tìm kiếm.
-- Kết quả trả về danh sách các bài viết có nội dung chứa từ khóa đó.

DELIMITER //
create procedure sp_SearchPost(input text)
begin
    select * from posts where content like concat('%', input, '%');
end //
DELIMITER ;

call sp_SearchPost('hello');

-- Task 3 (UPDATE): Viết thủ tục sp_IncreaseLike để tăng tương tác.
-- Sử dụng tham số IN cho post_id.
-- Sử dụng tham số INOUT để truyền vào số Like hiện tại và nhận lại số Like mới sau khi đã cộng thêm 1.
DELIMITER //
create procedure sp_IncreaseLike( post_id_in int)
begin
    update posts  
    set likes_count = likes_count + 1
    where post_id = post_id_in;
end //
DELIMITER ;
call sp_IncreaseLike(1);

select * from posts where post_id = 1;

DELIMITER //
create procedure sp_IncreaseLike2( post_id_in int, inout like_curr int)
begin
	set like_curr = like_curr + 1;
    update posts  
    set likes_count = like_curr
    where post_id = post_id_in;
end //
DELIMITER ;
set @like_current = 7;
call sp_IncreaseLike2(1, @like_current);
select @like_current;

-- Task 4 (DELETE): Viết thủ tục sp_DeletePost.
-- Sử dụng tham số IN là post_id để xóa bài viết tương ứng.
DELIMITER //
create procedure sp_DeletePost( post_id_in int)
begin
	delete from posts  
    where post_id = post_id_in;
end //
DELIMITER ;
call sp_DeletePost(18);
select * from posts;

-- 3. Kiểm tra và Dọn dẹp
drop procedure if exists sp_CreatePost;
drop procedure if exists sp_SearchPost ;
drop procedure if exists sp_IncreaseLike ;
drop procedure if exists sp_DeletePost;