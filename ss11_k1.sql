-- Sử dụng db social_network_pro
use social_network_pro;

-- 2) Tạo stored procedure có tham số IN nhận vào p_user_id:
-- Tạo stored procedure nhận vào mã người dùng p_user_id và trả về danh sách bài viết của user đó.Thông tin trả về gồm:
-- PostID (post_id)
-- Nội dung (content)
-- Thời gian tạo (created_at)

DELIMITER //
create procedure getPostsOfUser(p_user_id int)
begin
	select post_id, content, created_at from posts 
    where user_id = p_user_id;
end //
DELIMITER ;

-- 3) Gọi lại thủ tục vừa tạo với user cụ thể
call getPostsOfUser(1);

-- 4) Xóa thủ tục vừa tạo.
drop procedure if exists getPostsOfUser;

