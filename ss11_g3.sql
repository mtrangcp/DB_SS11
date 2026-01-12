-- 1) Sử dụng lại database social_network_pro để thao tác
-- 2) Viết stored procedure tên CalculateBonusPoints nhận hai tham số:
-- p_user_id (INT, IN) – ID của user
-- p_bonus_points (INT, INOUT) – Điểm thưởng ban đầu (khi gọi procedure, bạn truyền vào một giá trị điểm khởi đầu, ví dụ 100).
-- Trong procedure:
-- Đếm số lượng bài viết (posts) của user đó.
-- Nếu số bài viết ≥ 10, cộng thêm 50 điểm vào p_bonus_points.
-- Nếu số bài viết ≥ 20, cộng thêm tổng cộng 100 điểm (thay vì chỉ 50).
-- Cuối cùng, tham số p_bonus_points sẽ được sửa đổi và trả ra giá trị mới.

DELIMITER //
create procedure CalculateBonusPoints(p_user_id int, inout p_bonus_points int)
begin
	declare total_posts int;
 	set total_posts = (select count(post_id) from posts where user_id = p_user_id);
    if total_posts >= 10 then
		set p_bonus_points = p_bonus_points + 50;
	elseif  total_posts >= 20 then
		set p_bonus_points = p_bonus_points + 100;
    else     
		set p_bonus_points = p_bonus_points + 150;
	end if;
end //
DELIMITER ;
set @p_bonus_point = 100;
call CalculateBonusPoints(1, @p_bonus_point);
select @p_bonus_point;

drop procedure if exists CalculateBonusPoints;