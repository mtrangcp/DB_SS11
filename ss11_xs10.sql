-- 1) Sử dụng lại database social_network_pro 
-- 2)  Viết stored procedure tên NotifyFriendsOnNewPost nhận hai tham số IN:
-- p_user_id (INT) – ID của người đăng bài
-- p_content (TEXT) – Nội dung bài viết
-- Procedure sẽ thực hiện hai việc:

-- Thêm một bài viết mới vào bảng posts với user_id và content được truyền vào.
-- Tự động gửi thông báo loại 'new_post' vào bảng notifications cho tất cả bạn bè đã accepted (cả hai chiều trong bảng friends).
-- Nội dung thông báo: “[full_name của người đăng] đã đăng một bài viết mới”.
-- Không gửi thông báo cho chính người đăng bài.

DELIMITER //
create procedure NotifyFriendsOnNewPost( p_user_id int, p_content text)
begin
	declare v_full_name varchar(100);
    select full_name into v_full_name from users where user_id = p_user_id;
    
	insert into posts(user_id, content) values (p_user_id, p_content);
    -- gui thong bao
    insert into notifications (user_id, type, content)
	select f.friend_id, 'new_post', concat(v_full_name, ' đã đăng một bài viết mới')
	from friends f
	where f.user_id = p_user_id and f.status = 'accepted'
 
	union

	select f.user_id, 'new_post', concat(v_full_name, ' đã đăng một bài viết mới')
	from friends f
	where f.friend_id = p_user_id and f.status = 'accepted';
end //
DELIMITER ;

call NotifyFriendsOnNewPost(1, 'chuyen khong qua bay gio mơi ke');

select * from notifications;

drop procedure if exists NotifyFriendsOnNewPost;
