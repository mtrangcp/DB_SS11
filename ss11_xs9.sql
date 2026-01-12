--  1) Sử dụng lại database social_network_pro để thực hành bài trên
-- 2)Viết procedure tên CalculateUserActivityScore nhận IN p_user_id (INT), trả về OUT activity_score (INT). 
-- Điểm được tính: mỗi post +10 điểm, mỗi comment +5 điểm, mỗi like nhận được +3 điểm. Sử dụng CASE hoặc IF để 
-- phân loại mức hoạt động (ví dụ: >500 “Rất tích cực”, 200-500 “Tích cực”, <200 “Bình thường”) 
-- và trả thêm OUT activity_level (VARCHAR(50)).

delimiter //
create procedure CalculateUserActivityScore(p_user_id int, out activity_score int, out activity_level varchar(50))
begin
	declare total_posts int; 
    declare total_cmts int;
    declare total_likes int;
	set total_posts = (select count(post_id) from posts where user_id = p_user_id);
	set total_cmts = (select count(comment_id) from comments where user_id = p_user_id);
	set total_likes = (select count(post_id) from posts where user_id = p_user_id);
    set activity_score = total_posts*10 + total_cmts*5 + total_likes*3 ;
    
    if activity_score > 500 then
		set activity_level = 'Rất tích cực';
	elseif activity_score >= 200 then
		set activity_level = 'Tích cực';
	else 
		set activity_level = 'Bình thường';
	end if;
end //
delimiter ;

call CalculateUserActivityScore(8, @score, @level);
select @score, @level;

drop procedure if exists CalculateUserActivityScore;
