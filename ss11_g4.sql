--  1) Sử dụng lại database social_network_pro để thực hành bài trên\
-- 2) Viết procedure tên CreatePostWithValidation nhận IN p_user_id (INT), IN p_content (TEXT). 
-- Nếu độ dài content < 5 ký tự thì không thêm bài viết và SET một biến thông báo lỗi 
-- (có thể dùng OUT result_message VARCHAR(255) để trả về thông báo “Nội dung quá ngắn” hoặc “Thêm bài viết thành công”).

delimiter //
create procedure CreatePostWithValidation(p_user_id int, p_content text, out result_message varchar(255))
begin
	if char_length(p_content) < 5 then
		set result_message = 'Nội dung quá ngắn';
	else
		insert into posts(user_id, content) values (p_user_id, p_content);
		set result_message = 'Thêm bài viết thành công';
    end if;
end //
delimiter ;

call CreatePostWithValidation(1, 'vvv', @rs);
select @rs;
