--    1) Sử dụng lại database social_network_pro  để tiến hành thao tác
-- 2) Tính tổng like của bài viết
-- Viết stored procedure CalculatePostLikes nhận vào:
-- IN p_post_id: mã bài viết
-- OUT total_likes: tổng số lượt like nhận được trên tất cả bài viết của người dùng đó

DELIMITER //
create procedure CalculatePostLikes(p_post_id int, out total_likes int)
begin
	set total_likes = (select count(user_id) as total from likes 
							where post_id = p_post_id);
end //
DELIMITER ;
set @total_like  = 0;
call  CalculatePostLikes(103, @total_like);
select @total_like;

-- 4) Xóa thủ tục vừa mới tạo trên
drop procedure if exists CalculatePostLikes;
