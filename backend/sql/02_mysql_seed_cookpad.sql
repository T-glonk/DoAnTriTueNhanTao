-- ====================================================================
-- FoodAI: Bộ dữ liệu 179 món ăn thực tế thu thập từ Cookpad VN
-- Tương thích 100% với MySQL Workbench
-- ====================================================================

USE foodai;

SET FOREIGN_KEY_CHECKS = 0;

-- Món ăn: Canh hoa atisô hầm giò heo
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('3ce4320f-d391-4eea-bf68-5c51d2a247f2', 'Canh hoa atisô hầm giò heo', '#2026cookpadapron', 'https://img-global.cpcdn.com/recipes/12b2497d1e7227d2/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 phần', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/26303749', 'QUÂN NGUYỄN')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('3ce4320f-d391-4eea-bf68-5c51d2a247f2', '1 kg giò heo gân', 'giò heo gân', '1 kg', 1),
('3ce4320f-d391-4eea-bf68-5c51d2a247f2', '2 bông atisô', 'bông atisô', '2', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('3ce4320f-d391-4eea-bf68-5c51d2a247f2', 1, 'Bông atisô chẻ nhỏ,lấy phần nhụy ra rồi rửa sạch.', 'https://img-global.cpcdn.com/steps/cb5c9388a5795536/400x400cq80/photo.jpg'),
('3ce4320f-d391-4eea-bf68-5c51d2a247f2', 2, 'Giò heo chặt khoanh vừa ăn, rửa sạch rồi trụng giò qua nước sôi để cho nước canh trong. Nấu sôi 3 lít nước cho giò heo lên hầm, nêm 1 muỗng cà phê muối, 1 muỗng canh nước mắm, 2 muỗng cà phê đường, 1/2 muỗng cà phê bột ngọt, 5 cái đầu hành đập dập. Cho bông atisô vô hầm lửa nhỏ cho đến khi giò mềm.', 'https://img-global.cpcdn.com/steps/42ec790900829dde/400x400cq80/photo.jpg'),
('3ce4320f-d391-4eea-bf68-5c51d2a247f2', 3, 'Nêm nếm lại cho vừa ăn, thêm tiêu, hành ngò cho thơm.', 'https://img-global.cpcdn.com/steps/2a31e140fc356936/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('3ce4320f-d391-4eea-bf68-5c51d2a247f2', 420, 30.0, 25.0, 20.0, 3.0, 63.1, 2.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('3ce4320f-d391-4eea-bf68-5c51d2a247f2', 'món nước');

-- Món ăn: Giò heo kho sả ớt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('c1bd98ba-da4a-43d2-96f2-6d82c24bee00', 'Giò heo kho sả ớt', '#2026cookpadapron', 'https://img-global.cpcdn.com/recipes/a0c7f3391817f1e0/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 phần', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26512544', 'QUÂN NGUYỄN')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('c1bd98ba-da4a-43d2-96f2-6d82c24bee00', '1 kg giò dưới heo', 'giò dưới heo', '1 kg', 1),
('c1bd98ba-da4a-43d2-96f2-6d82c24bee00', '5 cây sả', 'sả', '5 cây', 1),
('c1bd98ba-da4a-43d2-96f2-6d82c24bee00', '5 trái ớt', 'ớt', '5 trái', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('c1bd98ba-da4a-43d2-96f2-6d82c24bee00', 1, 'Giò heo chặt khoanh vừa ăn, cạo rửa sạch.', 'https://img-global.cpcdn.com/steps/9abc0ce84add5ca4/400x400cq80/photo.jpg'),
('c1bd98ba-da4a-43d2-96f2-6d82c24bee00', 2, 'Bắc làm nóng xíu dầu ăn, cho giò heo lên chiên sơ', 'https://img-global.cpcdn.com/steps/4217b31e054d8dab/400x400cq80/photo.jpg'),
('c1bd98ba-da4a-43d2-96f2-6d82c24bee00', 3, 'Cho sả đập dập, 2 muỗng canh nước mắm, 1 muỗng cà phê hạt nêm, 1 muỗng canh đường, 2 muỗng tương hột, 2 muỗng dầu hào, ớt trái cắt nhỏ lên.', 'https://img-global.cpcdn.com/steps/f69e9454f2581052/400x400cq80/photo.jpg'),
('c1bd98ba-da4a-43d2-96f2-6d82c24bee00', 4, 'Đổ nước lên ngập giò rồi kho lửa nhỏ đến khi giò mềm. Nêm nếm lại cho vừa ăn.', 'https://img-global.cpcdn.com/steps/74c6bd15446b6982/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('c1bd98ba-da4a-43d2-96f2-6d82c24bee00', 480, 30.0, 25.0, 24.0, 3.0, 33.0, 3.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('c1bd98ba-da4a-43d2-96f2-6d82c24bee00', 'món kho');

-- Món ăn: Cải Chua Xào Thịt Heo Rừng
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', 'Cải Chua Xào Thịt Heo Rừng', 'Là món xào khá ngon, bạn thử nấu nhé!', 'https://img-global.cpcdn.com/recipes/4c028676f9f0cf73/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/24491378', 'Rose Truong')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', '300 g thịt heo rừng', 'thịt heo rừng', '300 g', 1),
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', '300 g cải chua', 'cải chua', '300 g', 1),
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', '1 củ tỏi', 'tỏi', '1 củ', 1),
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', '3 muỗng mỡ', 'mỡ', '3 muỗng', 1),
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', '1 ít muối', 'muối', '1 ít', 1),
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', '1 muỗng cafe mắm', 'cafe mắm', '1 muỗng', 1),
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', '1 ít tiêu xay', 'tiêu xay', '1 ít', 1),
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', '1 muỗng dầu hào', 'dầu hào', '1 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', 1, 'Chuẩn bị các nguyên liệu sẵn sàng sạch sẽ để ráo.Làm nóng chảo cho mỡ và tỏi vào phi cho dậy mùi thơm. Rồi cho thịt heo rừng vào xào với xíu muối và dầu hào.', 'https://img-global.cpcdn.com/steps/48f0f76d04f692a8/400x400cq80/photo.jpg'),
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', 2, 'Rồi cho cải chua cắt miếng vừa ăn vào, đảo đều. Xào thêm 5 phút thì nêm nếm lại cho vừa khẩu vị', 'https://img-global.cpcdn.com/steps/45b4c1333deaf0f2/400x400cq80/photo.jpg'),
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', 3, 'Múc heo rừng xào cải chua ra dĩa rắc thêm ít tiêu xay. Kèm thêm chén mắm mặn dầm ớt để chấm thêm.', 'https://img-global.cpcdn.com/steps/6a6de92eae54303e/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', 480, 30.0, 31.0, 24.0, 6.5, 27.4, 3.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('eba02d97-1a4b-414d-bf32-49a38f4c9c6e', 'món xào');

-- Món ăn: Dựng heo hầm măng tươi
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', 'Dựng heo hầm măng tươi', 'Là món canh bổ dưỡng với nước dùng ngọt thanh, móng giò béo ngậy giòn sần sật hòa quyện cùng vị giòn ngọt của măng tươi lại không đắng nên rất ngon #2026CookpadApron', 'https://img-global.cpcdn.com/recipes/f80054af947fef6a/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26507510', 'Hoàng Thị Tố Hà')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', '800 gr dựng heo (móng giò)', 'r dựng heo', '800 g', 1),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', '800 gr măng le', 'r măng le', '800 g', 1),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', '6 củ hành tím', 'hành tím', '6 củ', 1),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', '100 gr hành lá, ngò rí', 'r hành lá, ngò rí', '100 g', 1),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', '1 muỗng cafe muối', 'cafe muối', '1 muỗng', 1),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', '2 muỗng cafe hạt nêm', 'cafe hạt nêm', '2 muỗng', 1),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', '2 muỗng cafe nước mắm', 'cafe nước mắm', '2 muỗng', 1),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', '1 muỗng cafe đường', 'cafe đường', '1 muỗng', 1),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', '1 muỗng cafe bột ngọt', 'cafe bột ngọt', '1 muỗng', 1),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', '1 muỗng cafe tiêu', 'cafe tiêu', '1 muỗng', 1),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', 'Ăn kèm: nước mắm gừng', 'ăn kèm', 'nước mắm gừng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', 1, 'Sơ chế nguyên liệu: Dựng heo chặt miếng vừa ăn, cạo sạch lông & ngâm nước muối 10 phút. Sau đó đun một nồi nước cùng ít muối + vài lát gừng rồi để dựng heo vào trụng sơ 5 phút cho hết máu bằm & bọt bẩn... Măng mua củ non đã luộc sẵn nhưng vẫn cho vào nồi nước với 2 muỗng cafe muối rồi luộc sôi khoảng 5 phút, mở nắp để độc tố tự nhiên trong măng bay hơi, vớt ra rửa lại, để ráo... Hành tím cắt lát, hành lá-ngò rí cắt nhỏ', 'https://img-global.cpcdn.com/steps/d0b8131e3b57825c/400x400cq80/photo.jpg'),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', 2, 'Cách hầm: Đặt măng vào trước rồi đến móng giò cùng hành tím cắt lát + ít hành lá, ngò rí bó lại & 2 muỗng cafe muối rồi để vào 1,5 lít nước lọc, sao cho nước ngập mặt thịt rồi đun sôi... Khi nước sôi già thì hạ lửa nhỏ & hầm liu riu trong khoảng 45 phút hoặc cho đến lúc dựng heo + măng chín mềm là được... Cuối cùng nêm nếm gia vị: nước mắm, hạt nêm, đường, bột ngọt theo vị nhà, tắt bếp vớt bó hành lá-ngò rí ra bỏ', 'https://img-global.cpcdn.com/steps/e70ef0bb4f546f87/400x400cq80/photo.jpg'),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', 3, 'Thành phẩm & trình bày: Múc canh ra tô lớn rồi để hành lá-ngò rí cắt nhỏ vào & rắc tiêu... Nước canh thanh ngọt tự nhiên, móng giò béo ngậy thơm phức, măng thấm vị mềm giòn ăn hoài không ngán... Ăn cùng cơm nóng hoặc bún tươi, chấm dựng heo với nước mắm gừng ớt cay rất ngon luôn', 'https://img-global.cpcdn.com/steps/bb458e3a64581e7a/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', 480, 30.0, 25.0, 24.0, 3.0, 65.9, 4.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', 'món ngon mỗi ngày'),
('052a5d6a-6ade-4a06-b1ef-a99589a6eae3', 'dễ làm');

-- Món ăn: Thịt Heo Rừng Kho Trứng
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('4fe8bcad-3675-44b0-b400-20c9513d4dfd', 'Thịt Heo Rừng Kho Trứng', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/43156874663f475b/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24798454', 'Rose Truong')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', '1/2 kg thịt nạc heo rừng', 'thịt nạc heo rừng', '1/2 kg', 1),
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', '3 quả trứng vịt', 'trứng vịt', '3 quả', 1),
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', '5 củ hành tím', 'hành tím', '5 củ', 1),
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', '3 muỗng mắm', 'mắm', '3 muỗng', 1),
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', '2 muỗng đường phèn', 'đường phèn', '2 muỗng', 1),
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', '1 muỗng cafe màu hàng', 'cafe màu hàng', '1 muỗng', 1),
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', '1 muỗng dầu hào', 'dầu hào', '1 muỗng', 1),
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', '2 muỗng mỡ', 'mỡ', '2 muỗng', 1),
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', '1/2 muỗng cafe tiêu xay', 'cafe tiêu xay', '1/2 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', 1, 'Thịt heo rừng rửa sạch sẽ để ráo. Trứng luộc 10 phút cho chín, lột sạch vỏ.', ''),
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', 2, 'Thịt heo rừng ướp với gia vị: hành tím giã nhỏ, tiêu xay, dầu hào, mắm, đường để 30 phút cho thấm. Làm nóng nồi cho dầu mỡ và hành tím giã nhỏ vào phi cho dậy mùi thơm. Rồi cho thêm nước sôi và trứng vịt, nước màu hàng. Đậy nắp nồi áp suất lại kho', 'https://img-global.cpcdn.com/steps/a240d8cee81df426/400x400cq80/photo.jpg'),
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', 3, 'Món này ăn kèm dưa giá muối chua, rau sống dưa leo, rau luộc đều ngon.', 'https://img-global.cpcdn.com/steps/0029eeb610051be2/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('4fe8bcad-3675-44b0-b400-20c9513d4dfd', 480, 30.0, 25.0, 24.0, 3.0, 26.6, 3.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('4fe8bcad-3675-44b0-b400-20c9513d4dfd', 'món kho');

-- Món ăn: Thịt Cốt Lết Khìa Nước Dừa
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('802871c1-f4f8-4bb8-93e2-9b130be40a96', 'Thịt Cốt Lết Khìa Nước Dừa', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/80479f9743c96cdf/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/16828047', 'Rose Truong')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '700 g thịt cốt lết', 'thịt cốt lết', '700 g', 1),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '1 củ tỏi', 'tỏi', '1 củ', 1),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '1/3 muỗng cafe ngũ vị hương', 'cafe ngũ vị hương', '1/3 muỗng', 1),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '2 muỗng dầu hào', 'dầu hào', '2 muỗng', 1),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '2 muỗng xì dầu', 'xì dầu', '2 muỗng', 1),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '3 muỗng nước mắm', 'nước mắm', '3 muỗng', 1),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '2 muỗng đường', 'đường', '2 muỗng', 1),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '1 ít nước màu hàng', 'nước màu hàng', '1 ít', 1),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '3 muỗng mỡ', 'mỡ', '3 muỗng', 1),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '1 muỗng cafe tiêu xay', 'cafe tiêu xay', '1 muỗng', 1),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', '1 trái dừa xiêm tươi để lấy nước', 'dừa xiêm tươi để lấy nước', '1 trái', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('802871c1-f4f8-4bb8-93e2-9b130be40a96', 1, 'Thịt rửa sạch sẽ để ráo nước. Làm nóng chảo cho mỡ và tỏi vào phi cho dậy mùi thơm, rồi cho thêm các gia vị còn lại vào nấu sôi lên. Rồi cho thịt vào', 'https://img-global.cpcdn.com/steps/ad9468449af54a4f/400x400cq80/photo.jpg'),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', 2, 'Cho thịt vào đảo đều cho săn lại. Rồi cho thêm nước dừa vào nấu liu riu cho đến khi cạn còn lại ít nước keo keo là được.', 'https://img-global.cpcdn.com/steps/aa8b445bc559ceff/400x400cq80/photo.jpg'),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', 3, 'Món này ăn với cơm cùng rau luộc, rau sống và dưa leo.', 'https://img-global.cpcdn.com/steps/f0fc1cb6620e67c6/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('802871c1-f4f8-4bb8-93e2-9b130be40a96', 300, 15.0, 25.0, 10.0, 3.0, 45.9, 3.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('802871c1-f4f8-4bb8-93e2-9b130be40a96', 'món ngon mỗi ngày'),
('802871c1-f4f8-4bb8-93e2-9b130be40a96', 'dễ làm');

-- Món ăn: Cá Lóc Kho Thịt Heo Quay
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('fbd07289-8d16-4f81-9359-b8cdd25a200a', 'Cá Lóc Kho Thịt Heo Quay', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/3106e64c902b0845/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25258257', 'Rose Truong')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('fbd07289-8d16-4f81-9359-b8cdd25a200a', '400 g cá lóc', 'cá lóc', '400 g', 1),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', '200 g thịt heo quay', 'thịt heo quay', '200 g', 1),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', '3 củ hành tím', 'hành tím', '3 củ', 1),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', '1 muỗng cafe tiêu giã nát', 'cafe tiêu giã nát', '1 muỗng', 1),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', '1 trái ớt sừng', 'ớt sừng', '1 trái', 1),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', '1/2 muỗng cafe nước màu hàng', 'cafe nước màu hàng', '1/2 muỗng', 1),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', '5 muỗng dầu ăn', 'dầu ăn', '5 muỗng', 1),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', '3 muỗng mắm', 'mắm', '3 muỗng', 1),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', '3 muỗng đường', 'đường', '3 muỗng', 1),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', '1 ít muối biển', 'muối biển', '1 ít', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('fbd07289-8d16-4f81-9359-b8cdd25a200a', 1, 'Cá lóc làm sạch sẽ để ráo, rồi ướp với 1 muỗng đường và ít muối biển để 20 phút. Sau đó làm nóng nồi cho dầu ăn và hành tím giã nhỏ vào phi cho dậy mùi thơm, rồi cho các gia vị còn lại vào khuấy đều, thêm cá vào ướp 15 phút rồi nấu lên, vớt sạch bọt nếu có.', 'https://img-global.cpcdn.com/steps/29384ce8b7836a56/400x400cq80/photo.jpg'),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', 2, 'Rồi cho thịt heo quay vào kho cùng. Nhỏ lửa kho liu riu cho đến khi còn lại ít nước cá kho là được.', 'https://img-global.cpcdn.com/steps/24fe2a524046cd80/400x400cq80/photo.jpg'),
('fbd07289-8d16-4f81-9359-b8cdd25a200a', 3, 'Múc cá kho ra dĩa, trang trí ít lá ngò rí, rắc thêm ít tiêu xay. Món này ăn kèm rau luộc, dưa leo, rau sống.', 'https://img-global.cpcdn.com/steps/a42adb43e5496e06/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('fbd07289-8d16-4f81-9359-b8cdd25a200a', 480, 30.0, 25.0, 24.0, 3.0, 46.7, 3.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('fbd07289-8d16-4f81-9359-b8cdd25a200a', 'món kho');

-- Món ăn: Bún bò viên giò heo
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('153282e4-292c-4bda-b07d-87728577dbf0', 'Bún bò viên giò heo', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/cb83ce57bc62770d/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/26194061', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('153282e4-292c-4bda-b07d-87728577dbf0', '1/4 cái giò heo', 'giò heo', '1/4 cái', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', '300 g bò viên', 'bò viên', '300 g', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', '1 kg bún', 'bún', '1 kg', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', 'Rau giá', 'rau giá', 'Tùy lượng', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', '50 g hành lá', 'hành lá', '50 g', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', '3 củ hành tím', 'hành tím', '3 củ', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', '1 mc muối', 'mc muối', '1', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', '1 mcf đường', 'mcf đường', '1', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', '1/2 mc hạt nêm', 'mc hạt nêm', '1/2', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', '2 mc nước mắm', 'mc nước mắm', '2', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', '1/2 mc tiêu xay', 'mc tiêu xay', '1/2', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', '1 mc tỏi phi', 'mc tỏi phi', '1', 1),
('153282e4-292c-4bda-b07d-87728577dbf0', 'Chanh, tương đen, đỏ và ớt sa tế', 'chanh, tương đen, đỏ và ớt sa tế', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('153282e4-292c-4bda-b07d-87728577dbf0', 1, 'Giò heo bóp muối rửa sạch, trụng nước sôi và rửa lại, cho vào nồi nấu 2l nước với muối, hạt nêm và hành củ', 'https://img-global.cpcdn.com/steps/fb2c90503097dd1c/400x400cq80/photo.jpg'),
('153282e4-292c-4bda-b07d-87728577dbf0', 2, 'Nấu sôi và tắt bếp, cho vào nồi ủ 45 phút cho giò heo mềm thì cho bò viên cắt nhỏ vào nấu sôi, thêm nước mắm và tắt bếp', 'https://img-global.cpcdn.com/steps/6a79843c55e8acde/400x400cq80/photo.jpg'),
('153282e4-292c-4bda-b07d-87728577dbf0', 3, 'Trụng bún ra tô, chan nước lèo, thêm giò heo và bò viên, cuối cùng thêm hành lá và tiêu xay, tỏi phi. Dọn kèm rau giá, chấm tương đen, tương đỏ và ớt sa tế, chanh cắt miếng', 'https://img-global.cpcdn.com/steps/01d5c77316c3200d/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('153282e4-292c-4bda-b07d-87728577dbf0', 600, 30.0, 61.0, 24.0, 6.5, 49.2, 1.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('153282e4-292c-4bda-b07d-87728577dbf0', 'món ngon mỗi ngày'),
('153282e4-292c-4bda-b07d-87728577dbf0', 'dễ làm');

-- Món ăn: Thịt chân giò kho cải chua
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', 'Thịt chân giò kho cải chua', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/6e32a5580fcf8389/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26439992', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', '1/4 cái giò heo rút xương', 'giò heo rút xương', '1/4 cái', 1),
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', '200 g cải chua', 'cải chua', '200 g', 1),
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', '50 g hành ngò', 'hành ngò', '50 g', 1),
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', '1 mc hành tỏi băm', 'mc hành tỏi băm', '1', 1),
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', '2 mc nước mắm', 'mc nước mắm', '2', 1),
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', '1 mc nước tương', 'mc nước tương', '1', 1),
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', '1 mcf đường', 'mcf đường', '1', 1),
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', 'Ít hạt nêm', 'ít hạt nêm', 'Tùy lượng', 1),
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', '1/2 chén nước', 'nước', '1/2 chén', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', 1, 'Phi thơm hành tỏi, cho chân giò rút xương cắt nhỏ vào đảo săn', 'https://img-global.cpcdn.com/steps/2d2ef5b86d9086cd/400x400cq80/photo.jpg'),
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', 2, 'Cho dưa chua cắt nhỏ vào đảo cùng rồi cho tất cả gia vị vào kho lửa nhỏ cho thịt chín mềm. Thịt mềm cho hành ngò cắt khúc vào', 'https://img-global.cpcdn.com/steps/12e8d05577e71d90/400x400cq80/photo.jpg'),
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', 3, 'Thêm ít tiêu xay và tỏi phi, trang trí thêm ít ngò cho đẹp', 'https://img-global.cpcdn.com/steps/520ca197318d4d2b/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', 480, 30.0, 31.0, 24.0, 6.5, 49.1, 4.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('4a3a5a8d-8fda-42c3-a7c0-4cadb5bfed0e', 'món kho');

-- Món ăn: Thịt ba rọi kho thơm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('cc022ce8-9a62-4db2-81cc-ea4b81482b84', 'Thịt ba rọi kho thơm', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/838744993c15a91d/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26499156', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('cc022ce8-9a62-4db2-81cc-ea4b81482b84', '400 g thịt ba rọi', 'thịt ba rọi', '400 g', 1),
('cc022ce8-9a62-4db2-81cc-ea4b81482b84', '1/4 trái thơm', 'thơm', '1/4 trái', 1),
('cc022ce8-9a62-4db2-81cc-ea4b81482b84', '1 mc hành tím băm', 'mc hành tím băm', '1', 1),
('cc022ce8-9a62-4db2-81cc-ea4b81482b84', '1/2 chén nước mắm tỏi ớt', 'nước mắm tỏi ớt', '1/2 chén', 1),
('cc022ce8-9a62-4db2-81cc-ea4b81482b84', '1 mc tương ớt', 'mc tương ớt', '1', 1),
('cc022ce8-9a62-4db2-81cc-ea4b81482b84', 'Tiêu xay và tỏi phi', 'tiêu xay và tỏi phi', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('cc022ce8-9a62-4db2-81cc-ea4b81482b84', 1, 'Thịt bóp muối rửa sạch, cắt lát. Cho thịt vào chảo đảo cho cháy cạnh và thịt ra mỡ thì cho hành tím vào phi thơm', 'https://img-global.cpcdn.com/steps/005b07360b0cab9f/400x400cq80/photo.jpg'),
('cc022ce8-9a62-4db2-81cc-ea4b81482b84', 2, 'Tiếp tục cho nước mắm và tương ớt vào rồi cho thơm vào cùng, kho lửa nhỏ 20 phút', 'https://img-global.cpcdn.com/steps/a820c5085d434ca6/400x400cq80/photo.jpg'),
('cc022ce8-9a62-4db2-81cc-ea4b81482b84', 3, 'Khi thơm mềm và cạn nước thì tắt bếp, thêm tiêu xay và tỏi phi', 'https://img-global.cpcdn.com/steps/e83b297b02353f57/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('cc022ce8-9a62-4db2-81cc-ea4b81482b84', 300, 15.0, 25.0, 10.0, 3.0, 22.5, 2.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('cc022ce8-9a62-4db2-81cc-ea4b81482b84', 'món kho');

-- Món ăn: Thịt nạc kho nước dừa
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', 'Thịt nạc kho nước dừa', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/be2ad91acf33813d/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26466865', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', '800 g thịt nạc', 'thịt nạc', '800 g', 1),
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', '2 trái dừa', 'dừa', '2 trái', 1),
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', '2 mc nước mắm', 'mc nước mắm', '2', 1),
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', '2 mcf đường', 'mcf đường', '2', 1),
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', '1/2 mc muối', 'mc muối', '1/2', 1),
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', '1/2 mcf hạt nêm', 'mcf hạt nêm', '1/2', 1),
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', '2 mc nước tương', 'mc nước tương', '2', 1),
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', '1 mc hành tỏi băm', 'mc hành tỏi băm', '1', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', 1, 'Thịt nạc bóp muối rửa sạch, ướp với các gia vị và 1/2mc hành tỏi băm, để tủ lạnh qua đêm. Sau đó phi thơm hành tỏi, cho thịt vào chiên sơ rồi cho nước dừa vào', 'https://img-global.cpcdn.com/steps/9933887699b966ab/400x400cq80/photo.jpg'),
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', 2, 'Kho nhỏ lửa 45 phút cho thịt thấm gia vị, nêm lại cho vừa ăn. Thịt chín thì cắt nhỏ', 'https://img-global.cpcdn.com/steps/f3208ff5948d5762/400x400cq80/photo.jpg'),
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', 3, 'Có thể cho thịt đã cắt lại vào nồi kho thêm 5 phút để mỗi miếng thịt đều thấm gia vị', 'https://img-global.cpcdn.com/steps/ec5a73b21efb2146/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', 300, 15.0, 25.0, 10.0, 3.0, 45.3, 2.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('0934fa23-2acc-4080-ab7a-c3dfa54a67e7', 'món kho');

-- Món ăn: Canh Đu Đủ Xanh Hầm Giò Heo
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('c79480de-d2ba-4d89-b447-267d9efc9d21', 'Canh Đu Đủ Xanh Hầm Giò Heo', 'Canh đu đu xanh hầm giò heo là món canh ngọt thanh, mát lành và vô cùng bổ dưỡng. Đu đủ xanh ngọt dẻo, bùi bùi được hầm cùng giò heo mềm róc xương, béo ngậy mà không ngấy. Nước canh hầm trong vắt, đậm đà vị ngọt tự nhiên, điểm thêm hành lá và ngò rí thơm nức, giúp giải nhiệt, rất tốt cho sức khỏe cả gia đình. #2026cookpadapron', 'https://img-global.cpcdn.com/recipes/977366272e242976/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 tô', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/25101530', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('c79480de-d2ba-4d89-b447-267d9efc9d21', '400 g Giò heo', 'giò heo', '400 g', 1),
('c79480de-d2ba-4d89-b447-267d9efc9d21', '300 g Đu đủ xanh', 'đu đủ xanh', '300 g', 1),
('c79480de-d2ba-4d89-b447-267d9efc9d21', '2 củ Hành tím', 'hành tím', '2 củ', 1),
('c79480de-d2ba-4d89-b447-267d9efc9d21', '10 g Ngò rí', 'ngò rí', '10 g', 1),
('c79480de-d2ba-4d89-b447-267d9efc9d21', '10 ml Nước mắm', 'nước mắm', '10 ml', 1),
('c79480de-d2ba-4d89-b447-267d9efc9d21', '5 g Muối', 'muối', '5 g', 1),
('c79480de-d2ba-4d89-b447-267d9efc9d21', '5 g Đường', 'đường', '5 g', 1),
('c79480de-d2ba-4d89-b447-267d9efc9d21', '2 g Tiêu xay', 'tiêu xay', '2 g', 1),
('c79480de-d2ba-4d89-b447-267d9efc9d21', '10 ml Dầu ăn', 'dầu ăn', '10 ml', 1),
('c79480de-d2ba-4d89-b447-267d9efc9d21', '1 lít Nước', 'ít nước', '1 l', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('c79480de-d2ba-4d89-b447-267d9efc9d21', 1, 'Giò heo rửa sạch, chần sơ qua nước sôi, để ráo.', 'https://img-global.cpcdn.com/steps/6d652a2523a09ccb/400x400cq80/photo.jpg'),
('c79480de-d2ba-4d89-b447-267d9efc9d21', 2, 'Ướp giò heo với nước mắm, muối, tiêu, đường trong 15 phút.', ''),
('c79480de-d2ba-4d89-b447-267d9efc9d21', 3, 'Hành tím băm nhỏ, phi thơm với dầu ăn, cho giò heo vào xào 3 phút.', ''),
('c79480de-d2ba-4d89-b447-267d9efc9d21', 4, 'Thêm nước sôi vào nồi, hầm giò heo lửa nhỏ 30 phút.', 'https://img-global.cpcdn.com/steps/b4a0234c3b9fea59/400x400cq80/photo.jpg'),
('c79480de-d2ba-4d89-b447-267d9efc9d21', 5, 'Đu đủ xanh gọt vỏ, bỏ hạt, cắt miếng vừa ăn, cho vào nồi hầm thêm 15 phút.', 'https://img-global.cpcdn.com/steps/8f5a038019171976/400x400cq80/photo.jpg'),
('c79480de-d2ba-4d89-b447-267d9efc9d21', 6, 'Nêm lại cho vừa ăn, rắc tiêu, ngò rí lên trên và dùng nóng.', 'https://img-global.cpcdn.com/steps/3504a1a29c9c731c/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('c79480de-d2ba-4d89-b447-267d9efc9d21', 420, 30.0, 25.0, 20.0, 3.0, 55.5, 3.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('c79480de-d2ba-4d89-b447-267d9efc9d21', 'món nước');

-- Món ăn: Sườn Non Kho Trứng Cút
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('859d6816-119e-409e-aeef-e1330b379cc7', 'Sườn Non Kho Trứng Cút', 'Sườn non kho trứng cút đậm đà, màu màu cánh gián đẹp mắt và vô cùng hao cơm. Sườn non mềm róc xương, béo ngậy kết hợp cùng trứng cút bùi bùi, ngấm trọn phần nước kho sệt ngọt thanh từ nước dừa tươi. Thêm chút ớt và tiêu xay cay nồng, món ăn mang hương vị ấm cúng, chuẩn vị mâm cơm gia đình. #2026cookpadapron', 'https://img-global.cpcdn.com/recipes/77382140e85d2c08/1200x630cq80/photo.jpg', 30, 'Trung bình', '6 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25742404', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('859d6816-119e-409e-aeef-e1330b379cc7', '500 g Sườn non', 'sườn non', '500 g', 1),
('859d6816-119e-409e-aeef-e1330b379cc7', '15 quả Trứng cút', 'trứng cút', '15 quả', 1),
('859d6816-119e-409e-aeef-e1330b379cc7', '2 muỗng canh Nước mắm', 'nước mắm', '2 muỗng canh', 1),
('859d6816-119e-409e-aeef-e1330b379cc7', '1 muỗng canh Đường', 'đường', '1 muỗng canh', 1),
('859d6816-119e-409e-aeef-e1330b379cc7', '1 muỗng canh Nước màu', 'nước màu', '1 muỗng canh', 1),
('859d6816-119e-409e-aeef-e1330b379cc7', '1 muỗng cà phê Tỏi băm', 'tỏi băm', '1 muỗng cà phê', 1),
('859d6816-119e-409e-aeef-e1330b379cc7', '1 muỗng cà phê Hành tím băm', 'hành tím băm', '1 muỗng cà phê', 1),
('859d6816-119e-409e-aeef-e1330b379cc7', '1/2 muỗng cà phê Tiêu', 'tiêu', '1/2 muỗng cà phê', 1),
('859d6816-119e-409e-aeef-e1330b379cc7', '1 muỗng canh Dầu ăn', 'dầu ăn', '1 muỗng canh', 1),
('859d6816-119e-409e-aeef-e1330b379cc7', '200 ml Nước dừa xiêm', 'nước dừa xiêm', '200 ml', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('859d6816-119e-409e-aeef-e1330b379cc7', 1, 'Sườn non rửa sạch, chặt miếng vừa ăn, trụng sơ qua nước sôi.', 'https://img-global.cpcdn.com/steps/914fba52925d5652/400x400cq80/photo.jpg'),
('859d6816-119e-409e-aeef-e1330b379cc7', 2, 'Trứng cút luộc chín, bóc vỏ.', 'https://img-global.cpcdn.com/steps/df0684ea04025501/400x400cq80/photo.jpg'),
('859d6816-119e-409e-aeef-e1330b379cc7', 3, 'Ướp sườn với nước mắm, đường, nước màu, tỏi, hành tím, tiêu trong 20 phút.', ''),
('859d6816-119e-409e-aeef-e1330b379cc7', 4, 'Phi thơm tỏi, hành với dầu ăn, cho sườn vào xào săn.', 'https://img-global.cpcdn.com/steps/793fc97ccd6f2c9d/400x400cq80/photo.jpg'),
('859d6816-119e-409e-aeef-e1330b379cc7', 5, 'Thêm nước dừa, kho lửa nhỏ đến khi sườn mềm.', 'https://img-global.cpcdn.com/steps/83b0ac06a53155f6/400x400cq80/photo.jpg'),
('859d6816-119e-409e-aeef-e1330b379cc7', 6, 'Cho trứng cút vào, kho thêm 15 phút cho thấm vị.', ''),
('859d6816-119e-409e-aeef-e1330b379cc7', 7, 'Nêm lại cho vừa ăn, tắt bếp.', 'https://img-global.cpcdn.com/steps/82eafa81b2686708/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('859d6816-119e-409e-aeef-e1330b379cc7', 480, 30.0, 25.0, 24.0, 3.0, 56.8, 1.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('859d6816-119e-409e-aeef-e1330b379cc7', 'món kho');

-- Món ăn: Canh đậu tương cùng thịt ba chỉ bò 🐂
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('be1be6bd-b194-4c32-b801-2ce1f423d0e0', 'Canh đậu tương cùng thịt ba chỉ bò 🐂', 'Thanh thanh tựa mấy nhà hàng thịt nướng nha', 'https://img-global.cpcdn.com/recipes/66abdc1cb9c5bcc0/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/26481047', 'sumi237')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('be1be6bd-b194-4c32-b801-2ce1f423d0e0', '150 gram ba chỉ bò', 'ram ba chỉ bò', '150 g', 1),
('be1be6bd-b194-4c32-b801-2ce1f423d0e0', '1/4 Cải thảo', 'cải thảo', '1/4', 1),
('be1be6bd-b194-4c32-b801-2ce1f423d0e0', '2 cái Nấm hương', 'nấm hương', '2 cái', 1),
('be1be6bd-b194-4c32-b801-2ce1f423d0e0', '1 thìa Tương 된짱', 'tương 된짱', '1 thìa', 1),
('be1be6bd-b194-4c32-b801-2ce1f423d0e0', '700 ml Nước dùng cá cơm', 'nước dùng cá cơm', '700 ml', 1),
('be1be6bd-b194-4c32-b801-2ce1f423d0e0', '1/2 bìa đậu', 'bìa đậu', '1/2', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('be1be6bd-b194-4c32-b801-2ce1f423d0e0', 1, 'Xào sơ qua thịt bò với tỏi sau đó thêm 1 thìa tương 된짱 vào xào sơ dùng ba chỉ sẽ hơi mỡ nên có thể bỏ bớt dầu thừa ra trước rồi xào sơ tương nha.Thêm nước dùng cá cơm.Thêm xíu hạt nêm bò và chút muối cho vừa vị khi nước sôi thêm cải thảo,nấm và khi rau củ chín thì cho đậu và thêm xíu bột nêm gà cho thanh.Khi ăn thêm hành thôi.Ăn cùng cơm trắng cá thu lắc bột cà ri chiên giòn siu bắt cơm 🌿🌿🌿', 'https://img-global.cpcdn.com/steps/f7d9572c8be17acf/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('be1be6bd-b194-4c32-b801-2ce1f423d0e0', 540, 30.0, 61.0, 20.0, 6.5, 58.4, 3.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('be1be6bd-b194-4c32-b801-2ce1f423d0e0', 'món nước');

-- Món ăn: Sườn heo hấp kiểu Hoa
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('9379469a-d0eb-405e-a292-f7f3c0d3ba82', 'Sườn heo hấp kiểu Hoa', 'Kích thích vị giác. Tầng tầng lớp lớp hương vị. Người nhà ăn bảo giống món giả cầy 😆', 'https://img-global.cpcdn.com/recipes/e3cf8f0b6c50c80a/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26466718', 'Allieyya ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', 'Sườn heo', 'sườn heo', 'Tùy lượng', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 nắp rượu nấu ăn Hua Tiao Chiew (ướp sườn)', 'nắp rượu nấu ăn hua tiao chiew', '1', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 ít bột ngô (ướp sườn)', 'bột ngô', '1 ít', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 ít tiêu trắng mịn (ướp sườn)', 'tiêu trắng mịn', '1 ít', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 miếng nhỏ cam khô (rửa sơ rồi bẻ mấy miếng nhỏ xíu)', 'nhỏ cam khô', '1 miếng', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 ít hành tím bằm', 'hành tím bằm', '1 ít', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 ít gừng bằm', 'gừng bằm', '1 ít', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 ít tỏi bằm', 'tỏi bằm', '1 ít', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 trái ớt (xắt nhỏ)', 'ớt', '1 trái', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 ít đậu đen muối (rửa sơ rồi bằm nhỏ)', 'đậu đen muối', '1 ít', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 tbsp dầu hào', 'dầu hào', '1 tbsp', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 tbsp nước tương', 'nước tương', '1 tbsp', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 tsp đường', 'đường', '1 tsp', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', '1 ít tiêu trắng mịn', 'tiêu trắng mịn', '1 ít', 1),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', 'Hành lá (thát nhỏ)', 'hành lá', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', 1, 'Ướp sườn với các nguyên liệu trên', ''),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', 2, 'Cho dầu ăn xào thơm hành tím, tỏi, gừng, đậu đen muối. Sau đó cho cam khô và ớt vào đảo chung. Cho dầu hào, đường, nước tương, tiêu trắng. Múc hỗn hợp ra ướp chung với sườn đang ướp ban nãy (xào thơm lên rồi ướp dậy mùi rất nhiều)', 'https://img-global.cpcdn.com/steps/830453d8916eca78/400x400cq80/photo.jpg'),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', 3, 'Ướp ít nhất 1 tiếng, nếu muốn có thể ướp qua đêm.', ''),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', 4, 'Đem đi hấp 30 phút. Nếu muốn mềm hơn thì thêm 10 phút nữa. Rắc hành lá. Dùng với cơm.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('9379469a-d0eb-405e-a292-f7f3c0d3ba82', 420, 30.0, 25.0, 20.0, 3.0, 50.0, 2.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', 'món ngon mỗi ngày'),
('9379469a-d0eb-405e-a292-f7f3c0d3ba82', 'dễ làm');

-- Món ăn: Ba Chỉ Sốt Nấm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('a1849889-d714-4211-bc9e-436140c9827c', 'Ba Chỉ Sốt Nấm', 'Mình đang thử các món khác nhau với loại nấm kim châm đơn giản, dễ làm.', 'https://img-global.cpcdn.com/recipes/79c0a7f0d333faab/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26459184', 'Hiệp Trần')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('a1849889-d714-4211-bc9e-436140c9827c', '500 g Thịt ba chỉ', 'thịt ba chỉ', '500 g', 1),
('a1849889-d714-4211-bc9e-436140c9827c', '100 g Nấm kim châm hoặc nấm hải sản', 'nấm kim châm hoặc nấm hải sản', '100 g', 1),
('a1849889-d714-4211-bc9e-436140c9827c', '4 quả Cà chua', 'cà chua', '4 quả', 1),
('a1849889-d714-4211-bc9e-436140c9827c', '1/2 củ Hành tây', 'hành tây', '1/2 củ', 1),
('a1849889-d714-4211-bc9e-436140c9827c', '1 nắm lớn Hành lá', 'lớn hành lá', '1 nắm', 1),
('a1849889-d714-4211-bc9e-436140c9827c', '1 củ Hành tím', 'hành tím', '1 củ', 1),
('a1849889-d714-4211-bc9e-436140c9827c', '1.5 thìa canh Nước mắm', 'nước mắm', '1.5 thìa canh', 1),
('a1849889-d714-4211-bc9e-436140c9827c', '1 thìa ăn cơm đường', 'ăn cơm đường', '1 thìa', 1),
('a1849889-d714-4211-bc9e-436140c9827c', '1 thìa ăn cơm bột canh', 'ăn cơm bột canh', '1 thìa', 1),
('a1849889-d714-4211-bc9e-436140c9827c', '1 thìa canh Dầu ăn', 'dầu ăn', '1 thìa canh', 1),
('a1849889-d714-4211-bc9e-436140c9827c', '100 ml Nước lọc', 'nước lọc', '100 ml', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('a1849889-d714-4211-bc9e-436140c9827c', 1, 'Thái nhỏ hành tây, nấm, cà chua, hành lá và thịt ba chỉ.', ''),
('a1849889-d714-4211-bc9e-436140c9827c', 2, 'Phi thơm hành tím với dầu ăn, cho nước mắm vào đảo đều.', ''),
('a1849889-d714-4211-bc9e-436140c9827c', 3, 'Thêm hành tây, nấm và cà chua vào xào đến khi cà chua chín mềm.', ''),
('a1849889-d714-4211-bc9e-436140c9827c', 4, 'Cho thịt ba chỉ vào xào cùng, nêm đường, bột canh.', ''),
('a1849889-d714-4211-bc9e-436140c9827c', 5, 'Khi thịt săn lại, thêm nước lọc, đậy vung đun nhỏ lửa vài phút.', ''),
('a1849889-d714-4211-bc9e-436140c9827c', 6, 'Khi thịt chín, cho hành lá vào đảo đều rồi tắt bếp.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('a1849889-d714-4211-bc9e-436140c9827c', 540, 30.0, 61.0, 20.0, 6.5, 43.0, 2.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('a1849889-d714-4211-bc9e-436140c9827c', 'món ngon mỗi ngày'),
('a1849889-d714-4211-bc9e-436140c9827c', 'dễ làm');

-- Món ăn: Lẩu giò heo táo đỏ thập cẩm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('4ee7e442-e96f-46a1-a835-64b170b4eb1c', 'Lẩu giò heo táo đỏ thập cẩm', '#2026CookpadApron Món ngon bổ dưỡng cho những dịp tụ họp', 'https://img-global.cpcdn.com/recipes/ba6be44614eadd61/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25724333', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', '1/2 cái giò heo', 'giò heo', '1/2 cái', 1),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', '50 g táo đỏ', 'táo đỏ', '50 g', 1),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', '1 kg bún', 'bún', '1 kg', 1),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', 'Topping các loại tùy ý: thịt, cá, trứng, thanh cua, rau, nấm, mướp..', 'topping các loại tùy ý', 'thịt, cá, trứng, thanh cua, rau, nấm, mướp..', 1),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', '50 g hành lá', 'hành lá', '50 g', 1),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', '1 mc tỏi phi', 'mc tỏi phi', '1', 1),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', 'Sốt chấm lẩu Kichi', 'sốt chấm lẩu kichi', 'Tùy lượng', 1),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', '1 mc muối', 'mc muối', '1', 1),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', '1 mcf hạt nêm', 'mcf hạt nêm', '1', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', 1, 'Bò, tôm, cá, râu mạch tuộc, thanh cua, trứng sơ chế sạch, để ráo', 'https://img-global.cpcdn.com/steps/d6a47d93da4d8d18/400x400cq80/photo.jpg'),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', 2, 'Chuẩn bị các loại rau ăn kèm. Bún trụng nước sôi và để ráo', 'https://img-global.cpcdn.com/steps/ba793cbab98d73d2/400x400cq80/photo.jpg'),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', 3, 'Nấm cắt gốc, rửa sạch. Sứa rửa qua và cho vào chén. Sốt chấm rót ra chén', 'https://img-global.cpcdn.com/steps/42b39fe8567b040d/400x400cq80/photo.jpg'),
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', 4, 'Giò heo bóp muối giấm rửa sạch, trụng nước sôi và rửa lại, cho vào nồi nấu sôi và ủ 90 phút cho mềm với gia vị. Giò mềm thì cho vào nồi lẩu, thêm táo đỏ, hành lá cắt khúc và tỏi phi. Dọn kèm các loại topping khác', 'https://img-global.cpcdn.com/steps/bd9bf2e12ee358d0/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('4ee7e442-e96f-46a1-a835-64b170b4eb1c', 600, 30.0, 55.0, 24.0, 3.0, 56.2, 1.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('4ee7e442-e96f-46a1-a835-64b170b4eb1c', 'món nước');

-- Món ăn: Thịt Lợn Xào Cà Chua Sốt Chua Ngọt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 'Thịt Lợn Xào Cà Chua Sốt Chua Ngọt', 'Món ăn đơn giản mà lại hao cơm ))', 'https://img-global.cpcdn.com/recipes/decacc8f33111294/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 phần', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/26442912', 'Hamy')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1/2 thìa cà phê Muối hao hao', 'muối hao hao', '1/2 thìa cà phê', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '2 thìa canh Dầu mè hoặc dầu ô liu', 'dầu mè hoặc dầu ô liu', '2 thìa canh', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '2 thìa canh Bột mì đa dụng', 'bột mì đa dụng', '2 thìa canh', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '2 nhánh Hành lá', 'hành lá', '2 nhánh', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1/2 thìa cà phê (tùy chọn) Lá oregano khô', 'lá oregano khô', '1/2 thìa cà phê', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1 thìa cà phê Mè đen', 'mè đen', '1 thìa cà phê', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1 thìa canh Giấm gạo', 'giấm gạo', '1 thìa canh', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1,5 thìa canh Đường', 'đường', '1,5 thìa canh', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1/2 thìa cà phê Hạt tiêu', 'hạt tiêu', '1/2 thìa cà phê', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '50 ml Nước lọc', 'nước lọc', '50 ml', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '300 g Thịt lợn cả nạc và mỡ, bỏ bì', 'thịt lợn cả nạc và mỡ, bỏ bì', '300 g', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1 thìa cà phê Hạt nêm', 'hạt nêm', '1 thìa cà phê', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1/2 thìa cà phê Mì chính', 'mì chính', '1/2 thìa cà phê', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '2 thìa canh Tương cà', 'tương cà', '2 thìa canh', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1 thìa cà phê (tùy chọn) Tương ớt', 'tương ớt', '1 thìa cà phê', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1 thìa canh Dầu hào', 'dầu hào', '1 thìa canh', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '1 thìa canh Nước mắm', 'nước mắm', '1 thìa canh', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '4 củ Hành khô', 'hành khô', '4 củ', 1),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', '2 quả Cà chua to, đặc ruột', 'cà chua to, đặc ruột', '2 quả', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 1, 'Luộc sơ thịt lợn, để nguội, thấm khô rồi cắt miếng vừa ăn.', ''),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 2, 'Áo thịt với bột mì và rắc tiêu, đảo nhẹ.', ''),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 3, 'Pha sốt: trộn nước mắm, dầu hào, tương ớt, tương cà, mì chính, muối, nước lọc.', ''),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 4, 'Cà chua cắt miếng, hành khô thái nhỏ.', ''),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 5, 'Làm nóng chảo, cho dầu mè/ôliu, áp chảo thịt đến khi xém vàng, vớt ra.', ''),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 6, 'Phi thơm hành khô, cho cà chua vào xào mềm, nêm hạt nêm.', ''),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 7, 'Cho thịt vào đảo đều, thêm sốt đã pha, đảo lửa lớn cho ngấm.', ''),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 8, 'Hạ lửa vừa, thêm tương cà, đường, giấm, đảo đến khi sốt sệt lại.', ''),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 9, 'Nêm nếm lại, thêm nước nếu cần, đun cạn sốt.', ''),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 10, 'Rắc tiêu, cho hành lá, đảo 1 phút, tắt bếp.', ''),
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 11, 'Bày ra đĩa, rắc mè đen, oregano khô nếu thích.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 420, 15.0, 55.0, 10.0, 3.0, 38.9, 1.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('69209aa7-f1a4-4469-9542-1f5f6825bbe3', 'món xào');

-- Món ăn: Canh cải xoong sườn heo kiểu Hoa
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('cbad38b1-00b4-4106-a690-75932c4ced16', 'Canh cải xoong sườn heo kiểu Hoa', 'Món canh kiểu Hoa thanh mát bổ dưỡng.', 'https://img-global.cpcdn.com/recipes/7545c5f0c7d522cc/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/26442390', 'Allieyya ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('cbad38b1-00b4-4106-a690-75932c4ced16', '1 bó cải xoong', 'cải xoong', '1 bó', 1),
('cbad38b1-00b4-4106-a690-75932c4ced16', '3 trái táo đỏ khô (red dates)', 'táo đỏ khô', '3 trái', 1),
('cbad38b1-00b4-4106-a690-75932c4ced16', '1 trái táo mật khô (honey date)', 'táo mật khô', '1 trái', 1),
('cbad38b1-00b4-4106-a690-75932c4ced16', '1/2 trái la hán quả', 'la hán quả', '1/2 trái', 1),
('cbad38b1-00b4-4106-a690-75932c4ced16', '1 nhúm kỷ tử (tuỳ)', 'nhúm kỷ tử', '1', 1),
('cbad38b1-00b4-4106-a690-75932c4ced16', '1 nhúm Nam hạnh nhân và Bắc hạnh nhân (Nan xing bei xing) (nếu có thì tốt, ko thì thôi)', 'nhúm nam hạnh nhân và bắc hạnh nhân', '1', 1),
('cbad38b1-00b4-4106-a690-75932c4ced16', 'Sườn heo', 'sườn heo', 'Tùy lượng', 1),
('cbad38b1-00b4-4106-a690-75932c4ced16', 'Muối', 'muối', 'Tùy lượng', 1),
('cbad38b1-00b4-4106-a690-75932c4ced16', 'Gừng hoặc hành tím hoặc rượu nấu ăn (khử mùi sườn heo)', 'gừng hoặc hành tím hoặc rượu nấu ăn', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('cbad38b1-00b4-4106-a690-75932c4ced16', 1, '(Hình gồm cải xoong và honey date). Luộc sơ sườn heo khử mùi rồi rửa sạch lại bằng nước vòi.', 'https://img-global.cpcdn.com/steps/1a0396eeb4f8b5ce/400x400cq80/photo.jpg'),
('cbad38b1-00b4-4106-a690-75932c4ced16', 2, 'Táo đỏ bỏ hạt. Cải xoong cắt bỏ phần thân già, để nguyên cọng dài, ko cần cắt nhỏ rau.', ''),
('cbad38b1-00b4-4106-a690-75932c4ced16', 3, 'Bắc nước thật sôi rồi mới thả rau vào (nếu ko rau sẽ bị đắng)', ''),
('cbad38b1-00b4-4106-a690-75932c4ced16', 4, 'Cho tất cả nguyên liệu vào (nguyên liệu khử mùi không bỏ vào), thêm muối (gia giảm). Hầm tới khi sườn mềm rục, rau vàng úa (tại cái món này rau phải vàng úa zậy đó 😅). Dùng với cơm.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('cbad38b1-00b4-4106-a690-75932c4ced16', 420, 30.0, 31.0, 20.0, 6.5, 43.4, 2.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('cbad38b1-00b4-4106-a690-75932c4ced16', 'món nước');

-- Món ăn: Thịt ba chỉ xào ớt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('96e04e5c-a28f-40a6-a151-657a057e6a8d', 'Thịt ba chỉ xào ớt', 'Món này nguyên liệu đúng thì phải dùng ớt xoắn Trung Quốc và thịt ba chỉ. Nhưng mình dùng nguyên liệu na ná thui. Bạn nào có đầy đủ nguyên liệu thì nấu sẽ chuẩn công thức hơn.', 'https://img-global.cpcdn.com/recipes/1457e74d6461bfc7/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/26440454', 'Allieyya ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('96e04e5c-a28f-40a6-a151-657a057e6a8d', '3-4 trái ớt lớn (mk dùng ớt Chili Banji - ớt Ấn Độ)', 'ớt lớn', '3-4 trái', 1),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', 'Thịt heo thăn xắt mỏng (nếu được thì dùng thịt ba chỉ)', 'thịt heo thăn xắt mỏng', 'Tùy lượng', 1),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', '1 ít đậu đen muối', 'đậu đen muối', '1 ít', 1),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', 'Tỏi bằm hoặc tỏi đập dập', 'tỏi bằm hoặc tỏi đập dập', 'Tùy lượng', 1),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', 'Ớt đỏ cay (tuỳ)', 'ớt đỏ cay', 'Tùy lượng', 1),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', '1 tbsp dầu hào', 'dầu hào', '1 tbsp', 1),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', '1 tbsp nước tương đậm màu', 'nước tương đậm màu', '1 tbsp', 1),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', '1 tbsp nước tương', 'nước tương', '1 tbsp', 1),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', '1 nhúm muối', 'nhúm muối', '1', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('96e04e5c-a28f-40a6-a151-657a057e6a8d', 1, 'Chuẩn bị: Ớt lớn xắt góc nhọn miếng bự vừa ăn, để nguyên hột. Thịt heo xắt mỏng. Tỏi đập dập để cả múi hoặc tỏi bằm. Ớt đỏ xắt nhỏ. (Ớt nhạt màu là ớt Ấn Độ, ớt đậm màu là ớt xoắn Trung Quốc)', 'https://img-global.cpcdn.com/steps/137953e03601a321/400x400cq80/photo.jpg'),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', 2, 'Làm nóng chảo, *không dùng dầu ăn* xào 2 loại ớt với 1 chút muối, áp chảo ớt lớn và ớt đỏ cho ớt hơi cháy để dậy mùi thơm. Rồi để riêng qua 1 bên.', ''),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', 3, 'Không dùng dầu* Cho thịt ba chỉ vào xào khô cháy cạnh cho ra mỡ.', ''),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', 4, 'Cho tỏi vào xào cùng thịt 1 lúc rồi cho đậu muối vào xào cùng. Cho dầu hào, 2 loại nước tương vào xào cùng.', 'https://img-global.cpcdn.com/steps/b68d1efba83e6c88/400x400cq80/photo.jpg'),
('96e04e5c-a28f-40a6-a151-657a057e6a8d', 5, 'Rang thịt cháy cạnh 1 lúc thì đổ 2 loại ớt vào xào chung. Đảo đều tới khi ớt đẫm gia vị là ok. Dùng với cơm nóng.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('96e04e5c-a28f-40a6-a151-657a057e6a8d', 480, 30.0, 25.0, 24.0, 3.0, 67.2, 2.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('96e04e5c-a28f-40a6-a151-657a057e6a8d', 'món xào');

-- Món ăn: Cơm nhà với tôm sốt mayonnaise, canh ba chỉ heo củ quả, salad trộn phô mai
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('87e69e12-be7b-4c58-81f8-1d15363cb1cf', 'Cơm nhà với tôm sốt mayonnaise, canh ba chỉ heo củ quả, salad trộn phô mai', 'Đầu tuần khởi động với những món ăn bổ dưỡng, tươi mới.', 'https://img-global.cpcdn.com/recipes/8199175ffbf989c7/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người lớn và 2 bé', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/26430219', 'hangtmhang')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('87e69e12-be7b-4c58-81f8-1d15363cb1cf', '400 g ba chỉ heo cắt lát mỏng', 'ba chỉ heo cắt lát mỏng', '400 g', 1),
('87e69e12-be7b-4c58-81f8-1d15363cb1cf', '400 g tôm thẻ tươi', 'tôm thẻ tươi', '400 g', 1),
('87e69e12-be7b-4c58-81f8-1d15363cb1cf', '1 tuýp nhỏ mayonnaise', 'tuýp nhỏ mayonnaise', '1', 1),
('87e69e12-be7b-4c58-81f8-1d15363cb1cf', '1/2 củ cà rốt, hành tây, củ cải, hành paro, dưa chuột, cà chua, bìa đậu hũ, phô mai miếng', 'cà rốt, hành tây, củ cải, hành paro, dưa chuột, cà chua, bìa đậu hũ, phô mai miếng', '1/2 củ', 1),
('87e69e12-be7b-4c58-81f8-1d15363cb1cf', '1 thìa canh hạt nêm ngưu báng và gia vị các loại mắm, muối, tiêu, tương cà, sữa tươi nguyên kem, bột bắp, giấm táo', 'hạt nêm ngưu báng và gia vị các loại mắm, muối, tiêu, tương cà, sữa tươi nguyên kem, bột bắp, giấm táo', '1 thìa canh', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('87e69e12-be7b-4c58-81f8-1d15363cb1cf', 1, 'Luộc tôm chín xong giữ lại nước để nấu canh. Tôm nguội thì bóc vỏ rồi cho muối và giấm táo vào ướp 15p thì thấm khô. Pha nước sốt với 6 thìa canh mayonnaise, 2 thìa canh tương cà, 2 thìa canh đường, 2 thìa canh sữa tươi nguyên kem, chút muối, tiêu, bột bắp. Cho tôm lắc bột bắp xong mang chiên vàng giòn, rồi rưới nước sốt lên là hoàn thành.', 'https://img-global.cpcdn.com/steps/09fc1f843d39bb5e/400x400cq80/photo.jpg'),
('87e69e12-be7b-4c58-81f8-1d15363cb1cf', 2, 'Rửa sạch và cắt các nguyên liệu theo sở thích của các thành viên. Cho dầu mè lên chảo, xào thịt heo săn, cho rau củ vào xào một lúc rồi cho nước luộc tôm vào đun sôi lên, thả đậu hũ vào, thêm gia vị bột nêm ngưu báng vào rồi thêm ít gia vị mắm muối tuỳ thích. Tắt bếp rắc hành paro lên là xong.', 'https://img-global.cpcdn.com/steps/1ffa4593d5bbfc76/400x400cq80/photo.jpg'),
('87e69e12-be7b-4c58-81f8-1d15363cb1cf', 3, 'Làm salad trộn với xà lách xắt nhỏ, cà chua bi bổ đôi, dưa chuột gọt vỏ cắt mỏng, vài miếng quả đào hồng tươi cho vị chua ngọt, thêm phô mai miếng bẻ nhỏ và mayonnaise vào nữa là xong.', 'https://img-global.cpcdn.com/steps/b9e829ec7a03b8b2/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('87e69e12-be7b-4c58-81f8-1d15363cb1cf', 540, 30.0, 61.0, 20.0, 6.5, 33.9, 1.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('87e69e12-be7b-4c58-81f8-1d15363cb1cf', 'món nước');

-- Món ăn: Sườn non nướng đơn giản
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('b4e2c212-81e7-4b09-9609-5720bb227aca', 'Sườn non nướng đơn giản', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/fb2907e342753df4/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25473631', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('b4e2c212-81e7-4b09-9609-5720bb227aca', '500 g sườn non', 'sườn non', '500 g', 1),
('b4e2c212-81e7-4b09-9609-5720bb227aca', '1 mcf dầu ớt sa tế', 'mcf dầu ớt sa tế', '1', 1),
('b4e2c212-81e7-4b09-9609-5720bb227aca', '3 mc nước tương', 'mc nước tương', '3', 1),
('b4e2c212-81e7-4b09-9609-5720bb227aca', '1 mc dầu hào', 'mc dầu hào', '1', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('b4e2c212-81e7-4b09-9609-5720bb227aca', 1, 'Sườn bóp muối giấm rửa sạch, ướp với các gia vị 30 phút', 'https://img-global.cpcdn.com/steps/9275bfa82d4e5e1a/400x400cq80/photo.jpg'),
('b4e2c212-81e7-4b09-9609-5720bb227aca', 2, 'Cho vào nồi chiên không dầu, nướng 160° 15 phút mỗi mặt', 'https://img-global.cpcdn.com/steps/73ecb2c96591bb90/400x400cq80/photo.jpg'),
('b4e2c212-81e7-4b09-9609-5720bb227aca', 3, 'Dùng nóng với cơm nóng rất ngon', 'https://img-global.cpcdn.com/steps/18de03f12dbf7d5c/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('b4e2c212-81e7-4b09-9609-5720bb227aca', 580, 30.0, 25.0, 32.0, 3.0, 78.7, 2.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('b4e2c212-81e7-4b09-9609-5720bb227aca', 'món ngon mỗi ngày'),
('b4e2c212-81e7-4b09-9609-5720bb227aca', 'dễ làm');

-- Món ăn: Canh cải ngọt nấu xương giò heo
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('e3be2711-a68a-41ee-8dfa-8d33335e743d', 'Canh cải ngọt nấu xương giò heo', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/647bc1a572d6b3f1/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/26234572', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('e3be2711-a68a-41ee-8dfa-8d33335e743d', '1/2 cái giò heo', 'giò heo', '1/2 cái', 1),
('e3be2711-a68a-41ee-8dfa-8d33335e743d', '1 bó cải ngọt', 'cải ngọt', '1 bó', 1),
('e3be2711-a68a-41ee-8dfa-8d33335e743d', '1 mcf muối', 'mcf muối', '1', 1),
('e3be2711-a68a-41ee-8dfa-8d33335e743d', '1/3 mcf hạt nêm', 'mcf hạt nêm', '1/3', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('e3be2711-a68a-41ee-8dfa-8d33335e743d', 1, 'Giò heo lọc xương, rửa sạch, trụng qua, rửa lại và luộc với gia vị, luộc 15 phút và ủ thêm 5 phút. Sau đó vớt thịt ra', 'https://img-global.cpcdn.com/steps/b4163020c2dd142b/400x400cq80/photo.jpg'),
('e3be2711-a68a-41ee-8dfa-8d33335e743d', 2, 'Cải ngọt rửa sạch cắt khúc. Nước sôi cho cải vào nồi xương hầm', 'https://img-global.cpcdn.com/steps/f67e0f357281329e/400x400cq80/photo.jpg'),
('e3be2711-a68a-41ee-8dfa-8d33335e743d', 3, 'Rau vừa chín tới thì tắt bếp, múc ra tô thêm ít tiêu xay', 'https://img-global.cpcdn.com/steps/4e181dc915d6a0e0/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('e3be2711-a68a-41ee-8dfa-8d33335e743d', 420, 30.0, 31.0, 20.0, 6.5, 72.1, 2.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('e3be2711-a68a-41ee-8dfa-8d33335e743d', 'món nước');

-- Món ăn: Giò heo đuôi heo chiên giòn
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', 'Giò heo đuôi heo chiên giòn', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/6559afdbea407edc/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26404042', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', '1 cái đuôi heo', 'đuôi heo', '1 cái', 1),
('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', '1/3 chân giò heo', 'chân giò heo', '1/3', 1),
('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', '1 chén nước chấm tắc', 'nước chấm tắc', '1 chén', 1),
('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', '1 mcf hạt nêm', 'mcf hạt nêm', '1', 1),
('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', '3 củ hành tím', 'hành tím', '3 củ', 1),
('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', '1 mcf muối', 'mcf muối', '1', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', 1, 'Giò heo và đuôi heo bóp muối giấm rửa sạch, trụng qua và rửa sạch, luộc chín mềm với muối, hạt nêm và củ hành bóc vỏ đập dập', 'https://img-global.cpcdn.com/steps/c91dd1d152c8d217/400x400cq80/photo.jpg'),
('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', 2, 'Sau đó cho vào nồi chiên không dầu để sấy cho khô phần da, khi chiên sẽ nổ da vàng giòn hơn, bật 200° 30 phút, sau đó chiên với dầu ăn cho nổ bì', 'https://img-global.cpcdn.com/steps/ee39ea4a3137feb4/400x400cq80/photo.jpg'),
('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', 3, 'Dọn cùng nước mắm tắc', 'https://img-global.cpcdn.com/steps/c170592a6053b3d9/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', 580, 30.0, 25.0, 32.0, 3.0, 78.6, 1.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('0710dd94-41d2-4f79-8cc4-8f7de2e2099e', 'chiên giòn');

-- Món ăn: Canh Sấu Sườn Non Giải Nhiệt Ngày Hè
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('c4f3492e-44f9-4947-842d-3e7dba442b1e', 'Canh Sấu Sườn Non Giải Nhiệt Ngày Hè', 'Canh sấu sườn non là món ăn giải nhiệt tuyệt vời không thể thiếu trong mâm cơm mùa hè. Vị chua thanh, dịu nhẹ đặc trưng của sấu tới hòa quyện hoàn hảo cùng sườn non ninh mềm, ngọt đậm đà. Bát canh nóng hổi, thơm phức mùi tàu giúp kích thích vị giác, xua tan cái nắng oi ả và mang lại cảm giác trôi cơm đến lạ.', 'https://img-global.cpcdn.com/recipes/86db11bc0767b746/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 tô', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/25062416', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('c4f3492e-44f9-4947-842d-3e7dba442b1e', '400 g Sườn non', 'sườn non', '400 g', 1),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', '5 quả Sấu', 'sấu', '5 quả', 1),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', '2 quả Cà chua', 'cà chua', '2 quả', 1),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', '2 củ Hành tím', 'hành tím', '2 củ', 1),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', '2 muỗng canh Nước mắm', 'nước mắm', '2 muỗng canh', 1),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', '1/2 muỗng cà phê Muối', 'muối', '1/2 muỗng cà phê', 1),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', '1/2 muỗng cà phê Đường', 'đường', '1/2 muỗng cà phê', 1),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', '1 muỗng canh Bột năng', 'bột năng', '1 muỗng canh', 1),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', '1 nhánh Ngò gai', 'ngò gai', '1 nhánh', 1),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', '1 lít Nước', 'ít nước', '1 l', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('c4f3492e-44f9-4947-842d-3e7dba442b1e', 1, 'Sườn non rửa với xíu dấm muối, trụng sơ, rửa sạch lại.', 'https://img-global.cpcdn.com/steps/1e806d08eca33ee9/400x400cq80/photo.jpg'),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', 2, 'Ướp sườn với nước mắm, hành tím băm trong 10 phút.', ''),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', 3, 'Phi thơm hành tím, cho cà chua, sấu, sườn vào xào 5 phút, nêm xíu muối.', 'https://img-global.cpcdn.com/steps/e0bf585573e4aa0f/400x400cq80/photo.jpg'),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', 4, 'Thêm nước, hầm nhỏ lửa 40 phút cho sườn mềm.', 'https://img-global.cpcdn.com/steps/273d88b91cc075d2/400x400cq80/photo.jpg'),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', 5, 'Nêm lại với muối, đường, nước mắm. Dầm sấu cho vị chua vừa ăn.', ''),
('c4f3492e-44f9-4947-842d-3e7dba442b1e', 6, 'Rắc mùi tàu cắt nhỏ lên trên, dùng nóng.', 'https://img-global.cpcdn.com/steps/c054355b89c1c907/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('c4f3492e-44f9-4947-842d-3e7dba442b1e', 420, 30.0, 25.0, 20.0, 3.0, 39.2, 4.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('c4f3492e-44f9-4947-842d-3e7dba442b1e', 'món nước');

-- Món ăn: Cơm nhà với thịt nạc vai kho tàu trứng, đậu cove bắp non xào viên phomai, canh ngao me chua thịt mọc
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('36d66798-40cf-45ed-890f-dad57d00f6a3', 'Cơm nhà với thịt nạc vai kho tàu trứng, đậu cove bắp non xào viên phomai, canh ngao me chua thịt mọc', 'Trời mưa ở nhà xì xụp canh chua', 'https://img-global.cpcdn.com/recipes/300911f4fd94d5fb/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người lớn và 2 bé', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/26383037', 'hangtmhang')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('36d66798-40cf-45ed-890f-dad57d00f6a3', '500 g nạc vai heo', 'nạc vai heo', '500 g', 1),
('36d66798-40cf-45ed-890f-dad57d00f6a3', '1 quả dừa xiêm', 'dừa xiêm', '1 quả', 1),
('36d66798-40cf-45ed-890f-dad57d00f6a3', '10 viên đậu hũ cá phô mai', 'viên đậu hũ cá phô mai', '10', 1),
('36d66798-40cf-45ed-890f-dad57d00f6a3', '150 g thịt mọc', 'thịt mọc', '150 g', 1),
('36d66798-40cf-45ed-890f-dad57d00f6a3', '1 kg ngao', 'ngao', '1 kg', 1),
('36d66798-40cf-45ed-890f-dad57d00f6a3', '1/3 quả dứa', 'dứa', '1/3 quả', 1),
('36d66798-40cf-45ed-890f-dad57d00f6a3', '1 quả cà chua', 'cà chua', '1 quả', 1),
('36d66798-40cf-45ed-890f-dad57d00f6a3', '10 quả ngô bao tử', 'ngô bao tử', '10 quả', 1),
('36d66798-40cf-45ed-890f-dad57d00f6a3', '4 quả trứng gà', 'trứng gà', '4 quả', 1),
('36d66798-40cf-45ed-890f-dad57d00f6a3', '1 nắm đậu cove', 'đậu cove', '1 nắm', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('36d66798-40cf-45ed-890f-dad57d00f6a3', 1, 'Luộc trứng gà chín thì bóc vỏ, cắt đôi. Ngao ngâm nước muối nhả cát rồi luộc sơ giữ lại nước luộc, bỏ vỏ ngao. Thịt nạc vai thái mỏng, ướp gia vị thìa mắm, thìa đường, hạt tiêu, hành tỏi băm trong 30p.', 'https://img-global.cpcdn.com/steps/2fc59df0717da3ae/400x400cq80/photo.jpg'),
('36d66798-40cf-45ed-890f-dad57d00f6a3', 2, 'Cắt đôi viên đậu hũ cá phô mai. Rửa và tước chỉ đậu que, bẻ miếng 5cm, ngô bao tử cắt đôi, dứa thái miếng, cà chua bổ múi.', 'https://img-global.cpcdn.com/steps/643c6960dd922581/400x400cq80/photo.jpg'),
('36d66798-40cf-45ed-890f-dad57d00f6a3', 3, 'Phi thơm hành tỏi, cho cà chua và dứa vào xào chín, cho nước luộc ngao và thịt mọc vào đun sôi, thêm ngao và nêm gia vị, tắt bếp rắc hành lá và rau răm.', 'https://img-global.cpcdn.com/steps/92b592b6924ac862/400x400cq80/photo.jpg'),
('36d66798-40cf-45ed-890f-dad57d00f6a3', 4, 'Thắng đường mắm caramel rồi cho thịt nạc vai đảo cho săn, đổ hết nước trong quả dừa vào nồi, kho lửa vừa trong 40p. Cho trứng vào kho thêm 15p nữa là xong.', 'https://img-global.cpcdn.com/steps/8ba76be7316b2506/400x400cq80/photo.jpg'),
('36d66798-40cf-45ed-890f-dad57d00f6a3', 5, 'Xào đậu que, ngô bao tử và viên đậu hũ cá phô mai với lửa to để giữ độ giòn, nêm rất ít gia vị để bé ăn nhạt.', 'https://img-global.cpcdn.com/steps/5c9a3a49bf47cb78/400x400cq80/photo.jpg'),
('36d66798-40cf-45ed-890f-dad57d00f6a3', 6, 'Pha thêm bát nước mắm tỏi ớt cho người lớn chấm riêng nữa là hoàn thành. Nên luộc thêm trứng gà cho bé ăn riêng đỡ mặn.', 'https://img-global.cpcdn.com/steps/2134ed1a4bcae50e/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('36d66798-40cf-45ed-890f-dad57d00f6a3', 540, 30.0, 55.0, 20.0, 3.0, 62.6, 2.6)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('36d66798-40cf-45ed-890f-dad57d00f6a3', 'món kho'),
('36d66798-40cf-45ed-890f-dad57d00f6a3', 'món xào'),
('36d66798-40cf-45ed-890f-dad57d00f6a3', 'món nước');

-- Món ăn: Chân giò kho nước tương
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('9a34823b-ee17-418d-bc1c-4b6546290fd8', 'Chân giò kho nước tương', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/a1297d5f669b1b38/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26346014', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('9a34823b-ee17-418d-bc1c-4b6546290fd8', '1/2 cái chân giò', 'chân giò', '1/2 cái', 1),
('9a34823b-ee17-418d-bc1c-4b6546290fd8', '1 mc đầu hành', 'mc đầu hành', '1', 1),
('9a34823b-ee17-418d-bc1c-4b6546290fd8', '4 mc nước tương', 'mc nước tương', '4', 1),
('9a34823b-ee17-418d-bc1c-4b6546290fd8', '1/2 chén nước', 'nước', '1/2 chén', 1),
('9a34823b-ee17-418d-bc1c-4b6546290fd8', '1 mcf đường', 'mcf đường', '1', 1),
('9a34823b-ee17-418d-bc1c-4b6546290fd8', '1/2 mcf hạt nêm', 'mcf hạt nêm', '1/2', 1),
('9a34823b-ee17-418d-bc1c-4b6546290fd8', '1 mc dầu hào', 'mc dầu hào', '1', 1),
('9a34823b-ee17-418d-bc1c-4b6546290fd8', '50 g hành lá', 'hành lá', '50 g', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('9a34823b-ee17-418d-bc1c-4b6546290fd8', 1, 'Phi thơm đầu hành, cho nước và các gia vị vào rồi cho giò heo đã bóp muối rửa sạch vào', 'https://img-global.cpcdn.com/steps/80520cc43c05f7bf/400x400cq80/photo.jpg'),
('9a34823b-ee17-418d-bc1c-4b6546290fd8', 2, 'Đun sôi và giảm lửa kho thêm 25 phút, khi nước cạn bớt thì cho hành lá cắt khúc vào', 'https://img-global.cpcdn.com/steps/d201c8f246ea2474/400x400cq80/photo.jpg'),
('9a34823b-ee17-418d-bc1c-4b6546290fd8', 3, 'Cuối cùng thêm ít tiêu xay cho thơm', 'https://img-global.cpcdn.com/steps/318103755045dc0a/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('9a34823b-ee17-418d-bc1c-4b6546290fd8', 300, 15.0, 25.0, 10.0, 3.0, 65.8, 3.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('9a34823b-ee17-418d-bc1c-4b6546290fd8', 'món kho');

-- Món ăn: Thịt heo chiên giòn kiểu Hoa (Hakka)
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('9cd11683-b08a-44fe-b7a2-393815f07435', 'Thịt heo chiên giòn kiểu Hoa (Hakka)', 'Thịt giòn xốp đẫm vị, đưa cơm. Hoặc có thể để nguyên tảng ba chỉ (đã lọc da) ướp qua đêm rồi chiên nguyên tảng. Chiên xong thái mỏng ăn.', 'https://img-global.cpcdn.com/recipes/28899f848405d93a/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26368521', 'Allieyya ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('9cd11683-b08a-44fe-b7a2-393815f07435', '300 gr Thịt heo ba chỉ', 'r thịt heo ba chỉ', '300 g', 1),
('9cd11683-b08a-44fe-b7a2-393815f07435', '1 tbsp Tỏi bằm thật nhuyễn', 'tỏi bằm thật nhuyễn', '1 tbsp', 1),
('9cd11683-b08a-44fe-b7a2-393815f07435', '1 tsp tiêu trắng loại mịn', 'tiêu trắng loại mịn', '1 tsp', 1),
('9cd11683-b08a-44fe-b7a2-393815f07435', '1 tbsp chao đỏ (dầm nhuyễn)', 'chao đỏ', '1 tbsp', 1),
('9cd11683-b08a-44fe-b7a2-393815f07435', '1 tsp đường', 'đường', '1 tsp', 1),
('9cd11683-b08a-44fe-b7a2-393815f07435', '1 Hua Tiao Chiew (rượu nấu ăn)', 'hua tiao chiew', '1', 1),
('9cd11683-b08a-44fe-b7a2-393815f07435', '1 trái trứng gà', 'trứng gà', '1 trái', 1),
('9cd11683-b08a-44fe-b7a2-393815f07435', '3 tbsp bột chiên giòn (thay thế bằng bột ngô hoặc bột năng đều được)', 'bột chiên giòn', '3 tbsp', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('9cd11683-b08a-44fe-b7a2-393815f07435', 1, 'Thịt ba chỉ lọc da đem bỏ đi. Thịt thái miếng mỏng (càng mỏng thì khi chiên càng giòn).', ''),
('9cd11683-b08a-44fe-b7a2-393815f07435', 2, 'Ướp hỗn hợp (tỏi, tiêu, chao đỏ, rượu nấu ăn, đường) vào thịt. Ướp ít nhất 1 tiếng.', ''),
('9cd11683-b08a-44fe-b7a2-393815f07435', 3, 'Chuẩn bị chảo dầu sôi.', ''),
('9cd11683-b08a-44fe-b7a2-393815f07435', 4, 'Sau 1 tiếng* Trộn trứng và bột chiên giòn vào hỗn hợp thịt', ''),
('9cd11683-b08a-44fe-b7a2-393815f07435', 5, 'Gắp từng lát thịt chiên đến khi ngả vàng. Gắp ra ngoài để lên vỉ thoáng hơi (để giữ được độ giòn)', ''),
('9cd11683-b08a-44fe-b7a2-393815f07435', 6, 'Để nguyên chảo dầu và lửa, đợi tầm 3-4 phút để dầu sôi lại. Thả thịt mới gắp ra chiên lại lần nữa cho giòn hơn là xong. Ăn kèm với dưa leo.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('9cd11683-b08a-44fe-b7a2-393815f07435', 580, 30.0, 25.0, 32.0, 3.0, 25.2, 4.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('9cd11683-b08a-44fe-b7a2-393815f07435', 'chiên giòn');

-- Món ăn: Ba chỉ kho măng
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('e0b365c9-e5b1-465d-98ef-8b09e46b9fd3', 'Ba chỉ kho măng', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/9175d2077cd8c423/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26359169', 'Khanh Tran')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('e0b365c9-e5b1-465d-98ef-8b09e46b9fd3', '500 gr măng tươi', 'r măng tươi', '500 g', 1),
('e0b365c9-e5b1-465d-98ef-8b09e46b9fd3', '300 gr thịt ba chỉ', 'r thịt ba chỉ', '300 g', 1),
('e0b365c9-e5b1-465d-98ef-8b09e46b9fd3', '1 ít gia vị nêm: mắm, muối, bột ngọt, bột nêm, tiêu, hành tỏi', 'gia vị nêm: mắm, muối, bột ngọt, bột nêm, tiêu, hành tỏi', '1 ít', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('e0b365c9-e5b1-465d-98ef-8b09e46b9fd3', 1, 'Rửa măng, xé sợi, luộc cho hết đắng và thải độc trong măng.', ''),
('e0b365c9-e5b1-465d-98ef-8b09e46b9fd3', 2, 'Xắt thịt ba chỉ, ướp mắm, hạt nêm, hành tỏi. Xào thịt với xíu dầu ăn cho săn thịt.', 'https://img-global.cpcdn.com/steps/9f28ce4860f30cbd/400x400cq80/photo.jpg'),
('e0b365c9-e5b1-465d-98ef-8b09e46b9fd3', 3, 'Cho măng vào xào. Nêm nếm gia vị: mắm, muối, xíu đường, bột nêm, tiêu, Cho xíu nước vào. Đậy nắp nấu cho măng thịt thấm gia vị chừng 15 phút.', 'https://img-global.cpcdn.com/steps/51b576b38cb222c8/400x400cq80/photo.jpg'),
('e0b365c9-e5b1-465d-98ef-8b09e46b9fd3', 4, 'Rắc hành lá lên, và dọn ăn thôi cả nhà.', 'https://img-global.cpcdn.com/steps/9ff6d57e0b2c22e4/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('e0b365c9-e5b1-465d-98ef-8b09e46b9fd3', 480, 30.0, 25.0, 24.0, 3.0, 23.2, 4.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('e0b365c9-e5b1-465d-98ef-8b09e46b9fd3', 'món kho');

-- Món ăn: Ba Rọi Rim Thơm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('61b26716-4013-468f-aad1-e88d43fe936b', 'Ba Rọi Rim Thơm', 'Món kho dân dã kiểu miền tây cho bữa cơm nhà #2026CookpadApron', 'https://img-global.cpcdn.com/recipes/1681de105cd2d369/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/16655689', 'Dory')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('61b26716-4013-468f-aad1-e88d43fe936b', '200 gr thịt ba chỉ', 'r thịt ba chỉ', '200 g', 1),
('61b26716-4013-468f-aad1-e88d43fe936b', '1/4 trái khóm 🍍', 'khóm', '1/4 trái', 1),
('61b26716-4013-468f-aad1-e88d43fe936b', '1 tép tỏi', 'tỏi', '1 tép', 1),
('61b26716-4013-468f-aad1-e88d43fe936b', '1 trái ớt hiểm', 'ớt hiểm', '1 trái', 1),
('61b26716-4013-468f-aad1-e88d43fe936b', 'Muối', 'muối', 'Tùy lượng', 1),
('61b26716-4013-468f-aad1-e88d43fe936b', 'Nước mắm', 'nước mắm', 'Tùy lượng', 1),
('61b26716-4013-468f-aad1-e88d43fe936b', 'Đường', 'đường', 'Tùy lượng', 1),
('61b26716-4013-468f-aad1-e88d43fe936b', 'Bột ngọt', 'bột ngọt', 'Tùy lượng', 1),
('61b26716-4013-468f-aad1-e88d43fe936b', 'Tiêu', 'tiêu', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('61b26716-4013-468f-aad1-e88d43fe936b', 1, 'Ba rọi cắt lát, ướp với 1/4 mcf muối rồi cho vào chảo nóng vừa đảo đến khi ra mỡ thì cho tỏi băm vào xào thơm, xào đến khi thịt rám cạnh, cho đường, bột ngọt, nước mắm vào rim thêm 5 phút cho thịt thấm vị', 'https://img-global.cpcdn.com/steps/0767db0777c4df4c/400x400cq80/photo.jpg'),
('61b26716-4013-468f-aad1-e88d43fe936b', 2, 'Thơm cắt miếng vừa ăn cho vào chảo rim cùng thịt thêm 5-7 phút nữa, nếu quá khô có thể thêm 1 ít nước và để rim đến khi ráo nước, gia giảm mặn ngọt theo khẩu vị.', 'https://img-global.cpcdn.com/steps/02f185a76b573f44/400x400cq80/photo.jpg'),
('61b26716-4013-468f-aad1-e88d43fe936b', 3, 'Trình bày ra dĩa thêm ớt hiểm xắt lát, dùng với cơm nóng.', 'https://img-global.cpcdn.com/steps/25f9b672034ed243/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('61b26716-4013-468f-aad1-e88d43fe936b', 480, 30.0, 25.0, 24.0, 3.0, 67.1, 1.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('61b26716-4013-468f-aad1-e88d43fe936b', 'món ngon mỗi ngày'),
('61b26716-4013-468f-aad1-e88d43fe936b', 'dễ làm');

-- Món ăn: Dưa Cải Chua Kho Ba Chỉ Chay
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 'Dưa Cải Chua Kho Ba Chỉ Chay', '#món_chay_dễ_làm', 'https://img-global.cpcdn.com/recipes/97badd4b4bdd268a/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 phần ăn', 'Món chay', 'https://cookpad.com/vn/cong-thuc/26332168', 'Bảo Bình ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', '300 g Dưa cải chua', 'dưa cải chua', '300 g', 1),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', '100 g Ba rọi chay', 'ba rọi chay', '100 g', 1),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 'Hạt nêm chay', 'hạt nêm chay', 'Tùy lượng', 1),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', '1 muỗng Nước mắm chay', 'nước mắm chay', '1 muỗng', 1),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', '1/2 muỗng cà phê Đường', 'đường', '1/2 muỗng cà phê', 1),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', '1 trái Ớt tươi', 'ớt tươi', '1 trái', 1),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', '1 muỗng canh Dầu ăn', 'dầu ăn', '1 muỗng canh', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 1, 'Dưa cải rửa sơ cho bớt chua mặn, để ráo.', ''),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 2, 'Ba rọi chay chiên sơ, cắt miếng vừa ăn.', ''),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 3, 'Xào dưa với hạt nêm, đường, nước mắm chay cho thấm vị.', 'https://img-global.cpcdn.com/steps/834f3897860b4aa1/400x400cq80/photo.jpg'),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 4, 'Om nhỏ lửa 25-30 phút đến khi dưa mềm.', 'https://img-global.cpcdn.com/steps/ede8b085d482832f/400x400cq80/photo.jpg'),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 5, 'Cho ba rọi chay vào, kho thêm 5-7 phút, không đảo mạnh tay.', 'https://img-global.cpcdn.com/steps/5d55efe4a089b316/400x400cq80/photo.jpg'),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 6, 'Thêm ớt tươi, tắt bếp, dọn ra thưởng thức.', 'https://img-global.cpcdn.com/steps/fd55d1aa2a146234/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 300, 15.0, 31.0, 10.0, 6.5, 66.0, 3.6)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 'chay'),
('d956e61a-fc1f-4e72-8cef-4e1ea61a653f', 'món kho');

-- Món ăn: Bún bò Huế giò heo
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', 'Bún bò Huế giò heo', '#2026CookpadApron Món ăn đặc trưng của xứ Huế, làm say lòng thực khách bốn phương khi có dịp thưởng thức', 'https://img-global.cpcdn.com/recipes/43fec790fcd2b842/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/25404192', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '1/2 giò heo', 'iò heo', '1/2 g', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '1 kg nạm bò', 'nạm bò', '1 kg', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '10 cây chả Huế', 'chả huế', '10 cây', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '200 g rau răm', 'rau răm', '200 g', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '4 mc ớt sa tế', 'mc ớt sa tế', '4', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '1 kg bún', 'bún', '1 kg', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '1 củ hành tây', 'hành tây', '1 củ', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '1/4 trái thơm', 'thơm', '1/4 trái', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '1 củ gừng', 'gừng', '1 củ', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '2 mc mắm ruốc', 'mc mắm ruốc', '2', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '2 mc muối', 'mc muối', '2', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '1 mc đường phèn', 'mc đường phèn', '1', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '3 mc nước mắm', 'mc nước mắm', '3', 1),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', '1 mcf tiêu xay', 'mcf tiêu xay', '1', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', 1, 'Nạm bò và giò heo bóp muối giấm rửa sạch, trụng nước sôi rồi rửa lại, sau đó cho vào nồi hầm với gừng, thơm, hành tây và muối, đường phèn, sa tế nấu sôi cho vào nồi ủ 90 phút cho thịt mềm, lưu ý lấy giò heo ra trước để giò không bị mềm quá', 'https://img-global.cpcdn.com/steps/bf947a99022697e8/400x400cq80/photo.jpg'),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', 2, 'Pha mắm ruốc vào chén nước, khuấy đều rồi cho phần nước ở trên vào nồi nước lèo, thêm nước mắm vào và nêm lại cho vừa vị', 'https://img-global.cpcdn.com/steps/fc34a0998f3ce307/400x400cq80/photo.jpg'),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', 3, 'Trụng bún cho ra tô, thêm giò heo, nạm bò, chả cây, chan nước lèo lên trên, cuối cùng thêm rau răm và tiêu xay', 'https://img-global.cpcdn.com/steps/af80729f9328b263/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', 600, 30.0, 61.0, 24.0, 6.5, 72.3, 3.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', 'món ngon mỗi ngày'),
('f70f7f4a-c3ca-4afe-b761-20cc2a26f689', 'dễ làm');

-- Món ăn: Bún Bò Tái Giò Heo Đơn Giản
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('6ddc0419-4502-480f-9dce-8afa9fb36833', 'Bún Bò Tái Giò Heo Đơn Giản', 'Bún bò tái giò heo là lựa chọn lý tưởng cho ngày nắng nóng. Nước dùng nấu đơn giản không hầm xương bò, trong thanh và dậy mùi thơm nức đặc trưng từ ruốc Huế. Điểm nhấn là những lát thịt bò tái mềm ngọt cùng khoanh giò heo ninh vừa chín tới, da giòn sần sật. Ăn kèm đĩa rau sống tươi mát giúp bữa trưa nhẹ nhàng, đủ chất mà không hề ngấy. #2026cookpadapron', 'https://img-global.cpcdn.com/recipes/531e73382ead50ce/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 tô', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/25120402', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('6ddc0419-4502-480f-9dce-8afa9fb36833', '300 g Giò heo', 'giò heo', '300 g', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '150 g Thịt bò thái mỏng', 'thịt bò thái mỏng', '150 g', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '1 nắm nhỏ Rau răm', 'nhỏ rau răm', '1 nắm', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '100 g Chả bì ớt xiêm xanh', 'chả bì ớt xiêm xanh', '100 g', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '2 muỗng cà phê Mắm ruốc', 'mắm ruốc', '2 muỗng cà phê', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '1 củ Hành tây', 'hành tây', '1 củ', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '4 cây Sả cây', 'sả cây', '4 cây', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '1.5 lít Nước lọc', 'ít nước lọc', '1.5 l', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '1 muỗng canh Đường', 'đường', '1 muỗng canh', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '2 muỗng canh Nước mắm', 'nước mắm', '2 muỗng canh', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '150 g Xà lách, rau thơm: húng quế, rau răm, chuối bào, muống bào', 'xà lách, rau thơm: húng quế, rau răm, chuối bào, muống bào', '150 g', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '500 g Bún tươi (sợi nhỏ to tuỳ ý thích)', 'bún tươi', '500 g', 1),
('6ddc0419-4502-480f-9dce-8afa9fb36833', '1 ít Hành tím ngâm chua ngọt', 'hành tím ngâm chua ngọt', '1 ít', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('6ddc0419-4502-480f-9dce-8afa9fb36833', 1, 'Giò heo trụng sơ, rửa sạch, cho vào nồi cùng sả đập dập, hành tây bổ múi, hầm 30 phút. Giò chín vớt ra xả qua nước đun sôi để nguội. Để ráo.', 'https://img-global.cpcdn.com/steps/804109a2708b91e5/400x400cq80/photo.jpg'),
('6ddc0419-4502-480f-9dce-8afa9fb36833', 2, 'Vớt bọt, thêm mắm ruốc đã lược, nước mắm, đường vào nồi nước dùng, nêm vừa ăn.', 'https://img-global.cpcdn.com/steps/49886c2c50c83488/400x400cq80/photo.jpg'),
('6ddc0419-4502-480f-9dce-8afa9fb36833', 3, 'Bún trụng nóng, cho vào tô, xếp thịt bò thái mỏng lên trên hoặc trụng bò vào nước lèo.', 'https://img-global.cpcdn.com/steps/778ae8e55d4499f7/400x400cq80/photo.jpg'),
('6ddc0419-4502-480f-9dce-8afa9fb36833', 4, 'Thêm giò heo, chả bì, rau răm, ớt xiêm xanh, hành tím ngâm và ớt đỏ cắt lát.', 'https://img-global.cpcdn.com/steps/aa469b42700d03db/400x400cq80/photo.jpg'),
('6ddc0419-4502-480f-9dce-8afa9fb36833', 5, 'Dọn kèm xà lách, rau thơm, rau muống bào, chuối bào tùy thích.', 'https://img-global.cpcdn.com/steps/97c7b5785fc99e2e/400x400cq80/photo.jpg'),
('6ddc0419-4502-480f-9dce-8afa9fb36833', 6, 'Chan nước vào tô. Thưởng thức khi còn nóng.', 'https://img-global.cpcdn.com/steps/2393fe620e98c22c/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('6ddc0419-4502-480f-9dce-8afa9fb36833', 600, 30.0, 61.0, 24.0, 6.5, 26.7, 2.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('6ddc0419-4502-480f-9dce-8afa9fb36833', 'món ngon mỗi ngày'),
('6ddc0419-4502-480f-9dce-8afa9fb36833', 'dễ làm');

-- Món ăn: Ba Rọi Rim Mắm Ruốc Huế
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('29be65df-124b-4f76-a7f1-211817fb9ae9', 'Ba Rọi Rim Mắm Ruốc Huế', '#2026CookpadApron #CayThomDacSanHue Mộc mạc nhưng đậm đà, đây là món ăn mang hương vị đặc trưng của xứ Huế. Mắm ruốc được xào thơm cùng sả băm và ớt, rồi rim chậm với những miếng ba rọi mềm béo để từng thớ thịt thấm đẫm vị mặn mà, ngọt hậu và thơm nồng. Món ăn này tuy dân dã, không cầu kỳ nhưng chứa đựng trọn vẹn nét tinh tế của ẩm thực Huế và sự ấm áp của bữa cơm gia đình #BaRoiRimMamRuocHue #HuynhPhatKitchen', 'https://img-global.cpcdn.com/recipes/5cc92fe143cc5a03/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26306512', 'Huỳnh Phát')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('29be65df-124b-4f76-a7f1-211817fb9ae9', '200 g thịt ba rọi', 'thịt ba rọi', '200 g', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '2 muỗng canh Mắm ruốc Huế', 'mắm ruốc huế', '2 muỗng canh', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '1/4 trái thơm băm nhuyễn', 'thơm băm nhuyễn', '1/4 trái', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '2 tbsp sả băm', 'sả băm', '2 tbsp', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '1 trái ớt sừng băm', 'ớt sừng băm', '1 trái', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '1 tbsp tỏi băm', 'tỏi băm', '1 tbsp', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '3 tép tỏi', 'tỏi', '3 tép', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '1/2 tbsp gừng băm', 'gừng băm', '1/2 tbsp', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '3 lát gừng', 'át gừng', '3 l', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '1/2 tbsp đường', 'đường', '1/2 tbsp', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '1/2 tsp bột ngọt', 'bột ngọt', '1/2 tsp', 1),
('29be65df-124b-4f76-a7f1-211817fb9ae9', '50 ml nước', 'nước', '50 ml', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('29be65df-124b-4f76-a7f1-211817fb9ae9', 1, 'Thịt ba rọi rửa sạch rồi xắt sợi to… Chuẩn bị sả, tỏi, ớt, gừng, thơm băm nhuyễn và chừa lại vài lát thơm, vài khoanh ớt để trang trí.', 'https://img-global.cpcdn.com/steps/24ddd6eac64440c3/400x400cq80/photo.jpg'),
('29be65df-124b-4f76-a7f1-211817fb9ae9', 2, 'Cho thịt ba rọi vô chảo với ít nước, thắng với 3 lát gừng và 3 tép tỏi cho thơm. Khi thịt ra bớt mỡ và sém cạnh thì vớt ra.', 'https://img-global.cpcdn.com/steps/881d53f91adac6a7/400x400cq80/photo.jpg'),
('29be65df-124b-4f76-a7f1-211817fb9ae9', 3, 'Dùng 3tbsp mỡ trong phần mỡ vừa thắng để phi thơm tỏi, sả, ớt, gừng băm cho thơm... Sau đó, ta cho thơm băm nhuyễn vào xào đến khi thơm trong lại.', 'https://img-global.cpcdn.com/steps/2978a9b2827f048c/400x400cq80/photo.jpg'),
('29be65df-124b-4f76-a7f1-211817fb9ae9', 4, 'Thêm 2tbsp mắm ruốc Huế và 50ml nước, khuấy đều để tạo thành một hỗn hợp loãng sệt.', 'https://img-global.cpcdn.com/steps/d546ce9a2492d285/400x400cq80/photo.jpg'),
('29be65df-124b-4f76-a7f1-211817fb9ae9', 5, 'Cho thịt vô, đảo đều. Sau đó, ta nêm đường, bột ngọt cho vừa ăn. Tiếp tục rim lửa nhỏ đến khi hỗn hợp mắm và thịt sánh lại vừa đủ thì tắt bếp… Cho món ăn ra dĩa, trang trí với vài lát thơm và mấy lát ớt. Dọn lên kèm dĩa rau thơm, dưa leo và trái vả xắt mỏng…', 'https://img-global.cpcdn.com/steps/f7b970807c6bb00c/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('29be65df-124b-4f76-a7f1-211817fb9ae9', 300, 15.0, 25.0, 10.0, 3.0, 39.3, 1.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('29be65df-124b-4f76-a7f1-211817fb9ae9', 'món ngon mỗi ngày'),
('29be65df-124b-4f76-a7f1-211817fb9ae9', 'dễ làm');

-- Món ăn: Ba Chỉ Nướng Riềng Mẻ Mắm Tôm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('674abde6-30a2-4913-9c62-5c2fb0ffad2f', 'Ba Chỉ Nướng Riềng Mẻ Mắm Tôm', 'Ba chỉ nướng riềng mẻ mắm tôm là món ngon nức tiếng của vùng đất Bắc. Miếng thịt ba chỉ béo ngậy được tẩm ướp kỹ lưỡng với riềng giã nhỏ, mẻ chua thanh và mắm tôm đậm đà. Khi nướng trên than hồng, thịt cháy cạnh vàng ươm, dậy mùi thơm nồng nàn, quyến rũ đặc trưng. Từng miếng thịt mềm ngọt, vừa vị, ăn kèm lá mơ, húng quế rất hợp nhâm nhi những ngày lành lạnh. #2026cookpadapron', 'https://img-global.cpcdn.com/recipes/3480fd254779c0c6/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25945619', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', '400 g Thịt ba chỉ rút sườn', 'thịt ba chỉ rút sườn', '400 g', 1),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', '30 g Riềng non xay (hoặc nước cốt riềng già)', 'riềng non xay', '30 g', 1),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', '20 g Mẻ', 'mẻ', '20 g', 1),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', '15 g Mắm tôm', 'mắm tôm', '15 g', 1),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', '5 g Đường', 'đường', '5 g', 1),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', '2 g Hạt tiêu', 'hạt tiêu', '2 g', 1),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', '1 muỗng canh Dầu điều', 'dầu điều', '1 muỗng canh', 1),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', '200 g Bún tươi', 'bún tươi', '200 g', 1),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', '50 g Rau sống (tía tô, húng, xà lách...)', 'rau sống', '50 g', 1),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', '1 quả chanh', 'chanh', '1 quả', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', 1, 'Thịt ba chỉ rửa sạch, cắt miếng vừa ăn.', 'https://img-global.cpcdn.com/steps/c809a295c44ea5ed/400x400cq80/photo.jpg'),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', 2, 'Ướp thịt với riềng xay, mẻ, mắm tôm, đường, hạt tiêu, dầu điều trong 30 phút.', 'https://img-global.cpcdn.com/steps/a9c0d1272f9124c8/400x400cq80/photo.jpg'),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', 3, 'Nướng thịt trên than hoặc nồi chiên không dầu đến khi vàng đều.', 'https://img-global.cpcdn.com/steps/3c6e1f96fae1459f/400x400cq80/photo.jpg'),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', 4, 'Pha mắm tôm chấm: mắm tôm, đường, nước cốt chanh, ớt, khuấy đều.', ''),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', 5, 'Ăn kèm thịt nướng với bún và rau sống.', 'https://img-global.cpcdn.com/steps/142188998ee0d686/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('674abde6-30a2-4913-9c62-5c2fb0ffad2f', 700, 30.0, 61.0, 32.0, 6.5, 23.6, 2.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', 'món ngon mỗi ngày'),
('674abde6-30a2-4913-9c62-5c2fb0ffad2f', 'dễ làm');

-- Món ăn: Thịt heo kho kiểu Hoa
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 'Thịt heo kho kiểu Hoa', 'Người nhà nấu thấy ngon quá nên học cách nấu.', 'https://img-global.cpcdn.com/recipes/ee401432eb0e6007/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26280130', 'Allieyya ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 'Thịt heo', 'thịt heo', 'Tùy lượng', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 'Trứng luộc', 'trứng luộc', 'Tùy lượng', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 'Nấm mèo', 'nấm mèo', 'Tùy lượng', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 'Đậu hũ ky', 'đậu hũ ky', 'Tùy lượng', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 'Nấm hương khô', 'nấm hương khô', 'Tùy lượng', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', '1 tbsp Nước tương', 'nước tương', '1 tbsp', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', '1 tbsp Dầu hào', 'dầu hào', '1 tbsp', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 'Gừng', 'gừng', 'Tùy lượng', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', '2-3 củ Hành tím', 'hành tím', '2-3 củ', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', '1 nắp Rượu nấu ăn (Shaoxing Wine - Hua Tiao Chiew)', 'nắp rượu nấu ăn', '1', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 'Rượu gạo', 'rượu gạo', 'Tùy lượng', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', '2-3 củ Tỏi', 'tỏi', '2-3 củ', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 'Nước lọc', 'nước lọc', 'Tùy lượng', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', '1 tbsp Nước tương đậm màu', 'nước tương đậm màu', '1 tbsp', 1),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', '1 tbsp sốt đậu lên men', 'sốt đậu lên men', '1 tbsp', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 1, 'Rửa thịt với muối. Luộc sơ thịt với gừng và hành tím, cho ít rượu gạo để khử mùi. Sau đó, vớt ra cắt miếng vừa ăn, để 1 bên', ''),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 2, 'Ngâm nấm mèo, đậu hũ ky, nấm hương (ngâm riêng lẻ). Khi ngâm mềm, cắt đậu hũ ky độ dài vừa ăn, nấm mèo để nguyên. Nấm hương cắt cùi gốc để riêng 1 bên (dùng để tăng mùi vị khi kho), cắt đôi phần thân. Giữ lại nước ngâm nấm hương để nấu.', ''),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 3, 'Cho dầu ăn xào gừng (cắt lát), 2-3 củ hành tím (bóc vỏ, để nguyên củ), 2-3 củ tỏi (bóc vỏ, để nguyên củ) đảo thơm. Cho sốt đậu lên men vào xào cùng, sau đó cho nấm mèo và thịt heo cắt sẵn xào đến khi săn vàng.', 'https://img-global.cpcdn.com/steps/00a2eb0c3bbfb030/400x400cq80/photo.jpg'),
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 4, 'Chuyển hỗn hợp xào từ chảo sang nồi kho. Cho nước ngâm nấm hương vào (giữ lại ít nước cuối bỏ đi vì có cặn). Thêm ít nước lọc. Gia vị cho nước tương thường, nước tương đậm màu, dầu hào, rượu nấu ăn (Hua Tiao Chiew). Cho cùi nấm hương nãy để riêng vào chung. Kho 45 phút là xong. Trước khi ăn thêm đậu hũ ky và trứng luộc, kho 10-15 phút rồi tắt bếp. Muốn thịt ngon và mềm hơn thì kho lâu thêm nữa.', 'https://img-global.cpcdn.com/steps/389a656a8c483fae/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 420, 30.0, 31.0, 20.0, 6.5, 70.2, 2.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('8fd223be-2d25-4d6e-a22c-a878a8ccb753', 'món kho');

-- Món ăn: Sườn cốt lết nướng mềm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('ad0c2460-b4d2-4740-b4ae-f56515aa19cc', 'Sườn cốt lết nướng mềm', 'Sườn ướp với các gia vị cho thấm rồi nướng giúp miếng thịt thơm mềm và không bị khô', 'https://img-global.cpcdn.com/recipes/386339c07d03bc1f/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25367365', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('ad0c2460-b4d2-4740-b4ae-f56515aa19cc', '2 miếng sườn cốt lết', 'sườn cốt lết', '2 miếng', 1),
('ad0c2460-b4d2-4740-b4ae-f56515aa19cc', 'Gia vị', 'gia vị', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('ad0c2460-b4d2-4740-b4ae-f56515aa19cc', 1, 'Thịt ngâm nước 15 phút cho sạch, rửa lại và ướp với 1mcf sữa đặc, 1mc nước tương, 1mcf dầu hào, 1mc tương ớt 15 phút cho thấm', 'https://img-global.cpcdn.com/steps/638c07ec6d0aca8c/400x400cq80/photo.jpg'),
('ad0c2460-b4d2-4740-b4ae-f56515aa19cc', 2, 'Cho vào nồi chiên không dầu, set 160° 10 phút, lật mặt bật thêm 5 phút nữa là xong. Lấy ra cắt miếng vừa ăn, rắc thêm ít tỏi phi', 'https://img-global.cpcdn.com/steps/9819edabec77d3cf/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('ad0c2460-b4d2-4740-b4ae-f56515aa19cc', 580, 30.0, 25.0, 32.0, 3.0, 23.8, 1.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('ad0c2460-b4d2-4740-b4ae-f56515aa19cc', 'món ngon mỗi ngày'),
('ad0c2460-b4d2-4740-b4ae-f56515aa19cc', 'dễ làm');

-- Món ăn: Thịt nạc heo nướng xoài bằm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('dab37799-825e-470c-815e-074aa339e4e6', 'Thịt nạc heo nướng xoài bằm', 'Món đơn giản và healthy để ăn cơm', 'https://img-global.cpcdn.com/recipes/0bcf5769bd67aa66/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26265378', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('dab37799-825e-470c-815e-074aa339e4e6', '300 g thịt nạc heo', 'thịt nạc heo', '300 g', 1),
('dab37799-825e-470c-815e-074aa339e4e6', '1/2 trái xoài Thái', 'xoài thái', '1/2 trái', 1),
('dab37799-825e-470c-815e-074aa339e4e6', 'Nước mắm tỏi ớt', 'nước mắm tỏi ớt', 'Tùy lượng', 1),
('dab37799-825e-470c-815e-074aa339e4e6', '2 mc nước tương', 'mc nước tương', '2', 1),
('dab37799-825e-470c-815e-074aa339e4e6', '1 mcf tương ớt', 'mcf tương ớt', '1', 1),
('dab37799-825e-470c-815e-074aa339e4e6', 'Ít ớt sa tế', 'ít ớt sa tế', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('dab37799-825e-470c-815e-074aa339e4e6', 1, 'Thịt ướp với gia vị trong 15 phút (lượng ướp chỉ dùng cho 1 miếng thịt nạc 300g trong hình). Nướng nồi chiên không dầu 160° 20 phút mỗi mặt', 'https://img-global.cpcdn.com/steps/bdb5445877d22174/400x400cq80/photo.jpg'),
('dab37799-825e-470c-815e-074aa339e4e6', 2, 'Cắt thịt thành lát mỏng', 'https://img-global.cpcdn.com/steps/2c80a5e788eba49e/400x400cq80/photo.jpg'),
('dab37799-825e-470c-815e-074aa339e4e6', 3, 'Bào xoài thành sợi ăn kèm, rưới thêm nước mắm tỏi ớt lên phần xoài bào', 'https://img-global.cpcdn.com/steps/da8c7f17dd263626/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('dab37799-825e-470c-815e-074aa339e4e6', 580, 30.0, 25.0, 32.0, 3.0, 23.7, 4.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('dab37799-825e-470c-815e-074aa339e4e6', 'món ngon mỗi ngày'),
('dab37799-825e-470c-815e-074aa339e4e6', 'dễ làm');

-- Món ăn: Bún Thái tôm giò heo
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', 'Bún Thái tôm giò heo', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/05c478c83a74de57/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/25514607', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', '1/2 cái giò heo', 'giò heo', '1/2 cái', 1),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', '200 g tôm', 'tôm', '200 g', 1),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', '1 kg bún', 'bún', '1 kg', 1),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', '50 g hành ngò', 'hành ngò', '50 g', 1),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', '4 củ hành tím', 'hành tím', '4 củ', 1),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', '1 mcf tỏi phi', 'mcf tỏi phi', '1', 1),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', '1/2 gói gia vị lẩu Thái', 'ói gia vị lẩu thái', '1/2 g', 1),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', '1 mcf muối', 'mcf muối', '1', 1),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', '1 mcf đường', 'mcf đường', '1', 1),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', 'Ít hạt nêm và tiêu xay', 'ít hạt nêm và tiêu xay', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', 1, 'Giò heo rửa sạch, trụng nước sôi rồi cho vào nồi hầm với muối, đường, hạt nêm và hành tím bóc vỏ đập dập cùng rễ ngò', 'https://img-global.cpcdn.com/steps/9dfb6c6b3d33dc54/400x400cq80/photo.jpg'),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', 2, 'Hầm 45 phút cho chân giò mềm thì thêm gói lẩu Thái vào, thêm tôm đã làm sạch vào cùng', 'https://img-global.cpcdn.com/steps/34e292de250cf3e8/400x400cq80/photo.jpg'),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', 3, 'Trụng bún cho vào tô, thêm nước dùng và giò heo, tôm, cuối cùng thêm hành ngò, tiêu xay và tỏi phi', 'https://img-global.cpcdn.com/steps/2f39ee4b7e3e2e9b/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', 600, 30.0, 55.0, 24.0, 3.0, 62.0, 1.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', 'món ngon mỗi ngày'),
('52be6b87-c543-4084-bf5a-d9a4acf1b5f1', 'dễ làm');

-- Món ăn: Canh rau ngót nấu giò heo
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', 'Canh rau ngót nấu giò heo', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/96d63a3312059de8/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/25724349', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', '1/2 cái giò heo', 'giò heo', '1/2 cái', 1),
('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', '1 bó rau ngót', 'rau ngót', '1 bó', 1),
('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', '2 củ hành tím', 'hành tím', '2 củ', 1),
('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', '1 mcf muối', 'mcf muối', '1', 1),
('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', '1/3 mcf hạt nêm', 'mcf hạt nêm', '1/3', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', 1, 'Giò heo rửa sạch, trụng nước sôi, rửa lại nhiều lần rồi cho vào nồi nấu với gia vị và hành bóc vỏ đập dập', 'https://img-global.cpcdn.com/steps/b51344d7c25c7a38/400x400cq80/photo.jpg'),
('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', 2, 'Rau tuốt lá, rửa sạch, vò sơ và để ráo', 'https://img-global.cpcdn.com/steps/197c469ae224903e/400x400cq80/photo.jpg'),
('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', 3, 'Khi giò heo mềm thì cho rau vào, nấu thêm 3 phút cho rau chín', 'https://img-global.cpcdn.com/steps/03039248bcd59274/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', 420, 30.0, 31.0, 20.0, 6.5, 42.1, 3.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('fcdfaa08-c014-4f2c-b06b-d983fbdeb4f9', 'món nước');

-- Món ăn: Mì soba xào thịt ba chỉ
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', 'Mì soba xào thịt ba chỉ', 'Lâu lâu dọn tủ lạnh mình gom những thứ còn chút chút nên mình làm món này #2026CookpadApron', 'https://img-global.cpcdn.com/recipes/d4acfd4e6105f41d/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/25893129', 'Huyen le Tran')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', '120g mì', 'mì', '120g', 1),
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', '100 g Bắp Cải Tím', 'bắp cải tím', '100 g', 1),
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', '200g thịt ba chỉ', 'thịt ba chỉ', '200g', 1),
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', '5 tép tỏi', 'tỏi', '5 tép', 1),
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', '2mcf bột nêm', 'mcf bột nêm', '2', 1),
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', '2mcf đường', 'mcf đường', '2', 1),
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', '1/cf tiêu', 'cf tiêu', '1/', 1),
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', '3 tép hành lá', 'hành lá', '3 tép', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', 1, 'Trụn mì bóp thấy mềm vớt ra rửa nước lạnh để ráo ướp vô 1mcf bột nêm 1mcf đường 1mcf dầu ăn', 'https://img-global.cpcdn.com/steps/3496f13c2cceb765/400x400cq80/photo.jpg'),
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', 2, 'Xắt bắp cải thành sợi do bắp cải này cứng nên mình đem trụn sơ. Hành lá cắt khúc. Thịt ba chỉ bỏ da xắt bản ướp vào 1mcf bột nêm 1mcf đường, xíu tiêu 1mcf dầu hào. đoạn chế biến máy mình không lưu nên không có hình', 'https://img-global.cpcdn.com/steps/0b125e52bed27c03/400x400cq80/photo.jpg'),
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', 3, 'Bắc chảo phi tỏi thơm cho thịt vào xào, đảo thịt chín cho bắp cải và hành lá vào cuối cùng cho mì vào xào đều nêm sơ và cho ra dĩa rắc tiêu lên. Có thể ăn với nước tương hay nước mắm chua ngọt', 'https://img-global.cpcdn.com/steps/a839193a1eb0ddb1/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', 600, 30.0, 61.0, 24.0, 6.5, 54.4, 1.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('c56bb0a0-1e84-426f-8783-1b9f9cc723f8', 'món xào');

-- Món ăn: MÌ tươi nấu sườn non
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('37d4b026-655e-4548-98c9-eaf8301bfa11', 'MÌ tươi nấu sườn non', 'Là món ăn sáng hoặc bữa chính giàu dinh dưỡng, chống ngán cho những ngày hè nắng nóng #2026CookpadApron', 'https://img-global.cpcdn.com/recipes/fb4cae3e8bcff19b/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25876928', 'Hoàng Thị Tố Hà')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('37d4b026-655e-4548-98c9-eaf8301bfa11', '10 vắt mì tươi (mì người Hoa)', 'vắt mì tươi', '10', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '600 gr sườn non', 'r sườn non', '600 g', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '1 củ hành tây', 'hành tây', '1 củ', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '5 củ hành tím', 'hành tím', '5 củ', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '1 chén tóp mỡ', 'tóp mỡ', '1 chén', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '2 muỗng canh nước mỡ heo', 'nước mỡ heo', '2 muỗng canh', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '10 tép hành lá', 'hành lá', '10 tép', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '10 trái ớt hiểm đỏ', 'ớt hiểm đỏ', '10 trái', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '3 muỗng cafe đường phèn', 'cafe đường phèn', '3 muỗng', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '2 muỗng cafe muối hạt', 'cafe muối hạt', '2 muỗng', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '1 muỗng canh hạt nêm', 'hạt nêm', '1 muỗng canh', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', '1 muỗng cafe tiêu', 'cafe tiêu', '1 muỗng', 1),
('37d4b026-655e-4548-98c9-eaf8301bfa11', 'Ăn kèm: rau xà lách, giá sống, hành tím chua ngọt, nước tương', 'ăn kèm', 'rau xà lách, giá sống, hành tím chua ngọt, nước tương', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('37d4b026-655e-4548-98c9-eaf8301bfa11', 1, 'Sơ chế nguyên liệu: Sườn non chặt khúc vừa ăn rồi ngâm rửa qua nước muối loãng xong trụng qua nồi nước sôi cho sạch bọt bẩn, sau đó rửa lại nước sạch, để ráo... Mì tươi trụng qua nồi nước sôi rồi vớt ra rửa qua nước lọc xong cho nước mỡ heo vào trộn đều để chống dính', 'https://img-global.cpcdn.com/steps/aedd1e3a5bbb9085/400x400cq80/photo.jpg'),
('37d4b026-655e-4548-98c9-eaf8301bfa11', 2, 'Hầm sườn: Để 1,5 lít nước lọc vào nồi cùng 2 muỗng cafe muối hạt, hành tím đập dập & hành tây rồi cho sườn non vào hầm với lửa nhỏ vừa, không đậy nắp nồi để nước được trong. Khi sườn mềm thì nêm nếm gia vị theo vị nhà: hạt nêm, đường phèn & đầu trắng hành lá (trong lúc hầm sườn nước sẽ cạn bớt, nên cho lại để đủ 1,5 lít nước bằng cách đánh dấu trước khi nấu)', 'https://img-global.cpcdn.com/steps/2f32d53ce6c460f6/400x400cq80/photo.jpg'),
('37d4b026-655e-4548-98c9-eaf8301bfa11', 3, 'Ăn kèm: Ớt cắt lát', 'https://img-global.cpcdn.com/steps/c394497773bcad63/400x400cq80/photo.jpg'),
('37d4b026-655e-4548-98c9-eaf8301bfa11', 4, 'Thành phẩm: Mì tươi dai thơm mùi đặc trưng, sườn non mềm ngon, nước hầm thanh ngọt... Ăn cùng tóp mỡ & hành tím chua ngọt hợp vị lắm luôn', 'https://img-global.cpcdn.com/steps/a724846c1992d261/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('37d4b026-655e-4548-98c9-eaf8301bfa11', 600, 30.0, 55.0, 24.0, 3.0, 73.7, 4.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('37d4b026-655e-4548-98c9-eaf8301bfa11', 'món ngon mỗi ngày'),
('37d4b026-655e-4548-98c9-eaf8301bfa11', 'dễ làm');

-- Món ăn: Sườn Non Rim Mặn Ngọt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('8f039db7-c79f-489c-8454-e8b3857e601b', 'Sườn Non Rim Mặn Ngọt', '#2026cookpadapron', 'https://img-global.cpcdn.com/recipes/07dba4c6ed41e524/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25846698', 'QUÂN NGUYỄN')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('8f039db7-c79f-489c-8454-e8b3857e601b', '600 g Sườn non', 'sườn non', '600 g', 1),
('8f039db7-c79f-489c-8454-e8b3857e601b', '1 muỗng cà phê Nước tương', 'nước tương', '1 muỗng cà phê', 1),
('8f039db7-c79f-489c-8454-e8b3857e601b', '2 muỗng canh Nước mắm', 'nước mắm', '2 muỗng canh', 1),
('8f039db7-c79f-489c-8454-e8b3857e601b', '1 muỗng canh Đường', 'đường', '1 muỗng canh', 1),
('8f039db7-c79f-489c-8454-e8b3857e601b', '1 muỗng canh Tương ớt', 'tương ớt', '1 muỗng canh', 1),
('8f039db7-c79f-489c-8454-e8b3857e601b', '2 tép (đập dập) Tỏi', 'tỏi', '2 tép', 1),
('8f039db7-c79f-489c-8454-e8b3857e601b', '1/2 muỗng cà phê Tiêu', 'tiêu', '1/2 muỗng cà phê', 1),
('8f039db7-c79f-489c-8454-e8b3857e601b', '1 trái (băm nhỏ) Ớt', 'ớt', '1 trái', 1),
('8f039db7-c79f-489c-8454-e8b3857e601b', '2 muỗng canh Dầu ăn', 'dầu ăn', '2 muỗng canh', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('8f039db7-c79f-489c-8454-e8b3857e601b', 1, 'Sườn non rửa sạch, chặt khúc vừa ăn, ướp sơ với nước tương 10 phút.', 'https://img-global.cpcdn.com/steps/e7e4a405eca8dbd3/400x400cq80/photo.jpg'),
('8f039db7-c79f-489c-8454-e8b3857e601b', 2, 'Đun nóng dầu, chiên sơ sườn cho hơi vàng các mặt.', 'https://img-global.cpcdn.com/steps/ee3bdcb028abe415/400x400cq80/photo.jpg'),
('8f039db7-c79f-489c-8454-e8b3857e601b', 3, 'Pha nước mắm, đường, tương ớt, tỏi, tiêu, ớt vào chén, khuấy đều. Cho hỗn hợp nước sốt vào sườn, đảo đều cho thấm. Thêm nước xấp mặt sườn, rim lửa nhỏ đến khi nước sánh lại, sườn mềm.', 'https://img-global.cpcdn.com/steps/e09b5a1724fa941a/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('8f039db7-c79f-489c-8454-e8b3857e601b', 480, 30.0, 25.0, 24.0, 3.0, 34.3, 3.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('8f039db7-c79f-489c-8454-e8b3857e601b', 'món ngon mỗi ngày'),
('8f039db7-c79f-489c-8454-e8b3857e601b', 'dễ làm');

-- Món ăn: Canh giò heo nấu đậu đen táo đỏ
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('5458b6a7-ad4b-4813-83e7-2ac5358226a3', 'Canh giò heo nấu đậu đen táo đỏ', '#2026CookpadApron Món ăn bổ dưỡng với nhiều màu sắc hấp dẫn', 'https://img-global.cpcdn.com/recipes/07441d20153013c7/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/25835601', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', '1/2 cái giò heo', 'giò heo', '1/2 cái', 1),
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', '50 g đậu đen', 'đậu đen', '50 g', 1),
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', '10 g kỉ tử', 'kỉ tử', '10 g', 1),
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', '30 g táo đỏ', 'táo đỏ', '30 g', 1),
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', '1 củ gừng nhỏ', 'gừng nhỏ', '1 củ', 1),
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', '30 g hành ngò', 'hành ngò', '30 g', 1),
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', '1 mcf muối', 'mcf muối', '1', 1),
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', '1/4 mcf hạt nêm', 'mcf hạt nêm', '1/4', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', 1, 'Giò heo bóp muối rửa sạch, đậu đen rửa lại, gừng bỏ vỏ cắt lát. Cho tất cả vào nồi cơm điện kèm gia vị', 'https://img-global.cpcdn.com/steps/07ea49adab807f2e/400x400cq80/photo.jpg'),
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', 2, 'Nước sôi thì rút dây điện, ủ qua đêm cho đậu và giò heo mềm. Đến sáng cho thêm táo đỏ và kỉ tử, nêm lại cho vừa vị, cuối cùng thêm hành ngò', 'https://img-global.cpcdn.com/steps/39d17c0dfefe92ae/400x400cq80/photo.jpg'),
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', 3, 'Múc canh ra tô, thêm ít tiêu xay', 'https://img-global.cpcdn.com/steps/29b75768b8427d8f/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('5458b6a7-ad4b-4813-83e7-2ac5358226a3', 420, 30.0, 25.0, 20.0, 3.0, 43.3, 3.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('5458b6a7-ad4b-4813-83e7-2ac5358226a3', 'món nước');

-- Món ăn: Giò heo hầm táo đỏ kỷ tử
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('104eec08-545d-4bed-bb8c-204b5e4bd5c3', 'Giò heo hầm táo đỏ kỷ tử', '#2026CookpadApron Món ăn nhiều màu sắc, vừa hấp dẫn vừa bổ dưỡng', 'https://img-global.cpcdn.com/recipes/6241713855414875/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25715135', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', '1 bộ xương gà', 'bộ xương gà', '1', 1),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', '1/2 cái giò heo', 'giò heo', '1/2 cái', 1),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', '1 trái bắp Mỹ', 'bắp mỹ', '1 trái', 1),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', '100 g nấm hương khô', 'nấm hương khô', '100 g', 1),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', '100 g táo đỏ, hạt sen khô và kỷ tử', 'táo đỏ, hạt sen khô và kỷ tử', '100 g', 1),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', '30 g hành lá', 'hành lá', '30 g', 1),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', '4 củ hành tím', 'hành tím', '4 củ', 1),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', '1 mc muối', 'mc muối', '1', 1),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', '1/2 mcf hạt nêm', 'mcf hạt nêm', '1/2', 1),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', '1 mc nước mắm', 'mc nước mắm', '1', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', 1, 'Xương gà và giò heo ngâm rửa sạch, cho vào nồi luộc cùng hành tím bóc vỏ đập dập, muối và hạt nêm', 'https://img-global.cpcdn.com/steps/7fc2fc9ad317b7e7/400x400cq80/photo.jpg'),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', 2, 'Bắp và nấm hương, hạt sen rửa sạch, cho vào hầm chung, đậy nắp ủ 60 phút cho đến khi các nguyên liệu mềm', 'https://img-global.cpcdn.com/steps/7ccb11b928d7a74a/400x400cq80/photo.jpg'),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', 3, 'Cuối cùng cho táo đỏ và kỷ tử vào nấu sôi, nêm nước mắm và gia vị khác tùy khẩu vị, rắc thêm hành lá và tiêu xay cho thơm', 'https://img-global.cpcdn.com/steps/a27b09474f9c88c3/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('104eec08-545d-4bed-bb8c-204b5e4bd5c3', 480, 30.0, 31.0, 24.0, 6.5, 31.8, 4.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', 'món ngon mỗi ngày'),
('104eec08-545d-4bed-bb8c-204b5e4bd5c3', 'dễ làm');

-- Món ăn: Thịt Ba Rọi Chiên Giòn Bì Lắc Tỏi Ớt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', 'Thịt Ba Rọi Chiên Giòn Bì Lắc Tỏi Ớt', 'Theo cách làm da heo mỡ chiên giòn thần thánh của bếp trưởng @toha_2591227 , tôi làm phiên bản có luôn thịt vẫn rất giòn ngon, da nổ rôm rốp ăn chơi rất thích #2026CookpadApron', 'https://img-global.cpcdn.com/recipes/e19b5b377d6922a5/1200x630cq80/photo.jpg', 30, 'Trung bình', '3-4 người ăn chơi uống bia hơi', 'Món chính', 'https://cookpad.com/vn/cong-thuc/16630595', 'Dory')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', '500 gr thịt ba rọi', 'r thịt ba rọi', '500 g', 1),
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', '1/2 cup dầu ăn (nếu thịt quá ít mỡ)', 'cup dầu ăn', '1/2', 1),
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', '1 mcf muối', 'mcf muối', '1', 1),
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', '1/2 mcf bột tỏi', 'mcf bột tỏi', '1/2', 1),
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', '1/3 mcf bột ớt', 'mcf bột ớt', '1/3', 1),
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', '1/4 mcf bột ngọt', 'mcf bột ngọt', '1/4', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', 1, 'Thịt ba rọi luộc nguyên tảng trong vài phút cho ra chất dơ rồi rửa sạch lại, cắt thành khối cỡ 2cm x 3cm', 'https://img-global.cpcdn.com/steps/a0bebfb6123201a9/400x400cq80/photo.jpg'),
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', 2, 'Cho vào chảo cùng muối và 1/2 chén nước nấu lửa trung bình đến cạn nước, đảo liên tục đến khi chảy mỡ, vì chiên cả thịt nên mỡ tan chậm phải thêm 1/2 chén dầu ăn nếu thịt quá ít mỡ, đảo liên tục trong quá trình chiên lần 1 đến khi thịt hơi vàng và da hơi nổ (tầm 15 phút)', 'https://img-global.cpcdn.com/steps/bebc239e6a1f9485/400x400cq80/photo.jpg'),
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', 3, 'Vớt ra để nguội hẳn', 'https://img-global.cpcdn.com/steps/1686e44454d9de78/400x400cq80/photo.jpg'),
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', 4, 'Chiên lần 2 đến khi da nổ giòn là vớt ra, lắc đều với bột tỏi và bột ớt', 'https://img-global.cpcdn.com/steps/0b3f73b1b581eba7/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', 400, 15.0, 25.0, 18.0, 3.0, 23.6, 4.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('10f3440b-c7f3-4fc8-a96e-e2f86b80b7e2', 'chiên giòn');

-- Món ăn: Ba Chỉ Sả Ớt EatWell
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('8fd68d7a-6f50-490d-b7a9-95466573b2d2', 'Ba Chỉ Sả Ớt EatWell', 'Ba Chỉ Xả Ớt EatWell', 'https://img-global.cpcdn.com/recipes/9807b6f4cda5aa79/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25776244', 'EatWell')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '400 g Ba chỉ heo', 'ba chỉ heo', '400 g', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '2 củ Hành tím', 'hành tím', '2 củ', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '1/2 muỗng cà phê Muối', 'muối', '1/2 muỗng cà phê', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '1 muỗng canh Nước mắm', 'nước mắm', '1 muỗng canh', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '1/2 muỗng cà phê Tiêu', 'tiêu', '1/2 muỗng cà phê', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '1 củ Hành khô', 'hành khô', '1 củ', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '3 tép Tỏi', 'tỏi', '3 tép', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '2 cây Sả băm', 'sả băm', '2 cây', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '1 quả Ớt băm', 'ớt băm', '1 quả', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '1 muỗng canh Tương ớt', 'tương ớt', '1 muỗng canh', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '1 muỗng cà phê Hạt nêm ngưu bàng', 'hạt nêm ngưu bàng', '1 muỗng cà phê', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '2 muỗng canh Nước lọc', 'nước lọc', '2 muỗng canh', 1),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', '3 muỗng canh Đường xylitol', 'đường xylitol', '3 muỗng canh', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', 1, 'Ba chỉ rửa sạch, luộc sơ với hành tím, vớt ra để nguội rồi thái con chì.', 'https://img-global.cpcdn.com/steps/5568ea4211ecbcac/400x400cq80/photo.jpg'),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', 2, 'Ướp thịt với muối, nước mắm, tiêu', 'https://img-global.cpcdn.com/steps/2177075e4928d5c3/400x400cq80/photo.jpg'),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', 3, 'Cho thịt vào nồi chiên không dầu, nướng 200 độ trong 15 phút.', ''),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', 4, 'Lấy mỡ từ thịt, phi thơm hành khô, tỏi, sả và ớt băm.', 'https://img-global.cpcdn.com/steps/4c47f4811a7ff24d/400x400cq80/photo.jpg'),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', 5, 'Cho thịt vào chảo, đảo đều với hỗn hợp sốt gồm: tương ớt, nước mắm, hạt nêm ngưu bàng, nước lọc, đường xylitol.', 'https://img-global.cpcdn.com/steps/0d989b8dfc69a524/400x400cq80/photo.jpg'),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', 6, 'Đảo lửa lớn khoảng 5 phút cho thịt áo đều sốt là xong.', 'https://img-global.cpcdn.com/steps/c4b3d8430eac3546/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('8fd68d7a-6f50-490d-b7a9-95466573b2d2', 480, 30.0, 25.0, 24.0, 3.0, 60.2, 4.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', 'món ngon mỗi ngày'),
('8fd68d7a-6f50-490d-b7a9-95466573b2d2', 'dễ làm');

-- Món ăn: Sườn Cốt Lết Áp Chảo EatWell
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', 'Sườn Cốt Lết Áp Chảo EatWell', 'Sườn Cốt Lết Áp Chảo EatWell', 'https://img-global.cpcdn.com/recipes/b0e574738118c4c9/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25760536', 'EatWell')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', '400-500 g Sườn cốt lết', 'sườn cốt lết', '400-500 g', 1),
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', '2 g Muối', 'muối', '2 g', 1),
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', '1 g Tiêu', 'tiêu', '1 g', 1),
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', '2 g Bột ngũ vị hương', 'bột ngũ vị hương', '2 g', 1),
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', '2 g Bột tỏi', 'bột tỏi', '2 g', 1),
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', '10 ml Xì dầu', 'xì dầu', '10 ml', 1),
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', '3 muỗng cà phê Đường xylitol', 'đường xylitol', '3 muỗng cà phê', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', 1, 'Dùng búa tán mỏng sườn cốt lết.', 'https://img-global.cpcdn.com/steps/314baeaea91e351a/400x400cq80/photo.jpg'),
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', 2, 'Ướp sườn với muối, tiêu, bột ngũ vị hương, bột tỏi, xì dầu và đường xylitol trong 15-20 phút.', 'https://img-global.cpcdn.com/steps/872a8b95f94ff0f4/400x400cq80/photo.jpg'),
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', 3, 'Làm nóng chảo, áp chảo sườn cho đến khi chín tới và vàng đều hai mặt.', 'https://img-global.cpcdn.com/steps/266b9fca4be517d7/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', 480, 30.0, 25.0, 24.0, 3.0, 73.9, 4.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('de0c4d3f-285f-45ea-9c0b-b7eb4a5924a3', 'món xào');

-- Món ăn: Cách nấu giò heo hầm quả vả
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('dd294e13-8a3b-40eb-b993-8badd8ca4f65', 'Cách nấu giò heo hầm quả vả', 'Chân giò heo hầm là một món canh vô cùng bổ dưỡng, được rất nhiều người ưa chuộng. Ngày hôm nay, mình sẽ giới thiệu đến các bạn món giò heo hầm vả, hứa hẹn sẽ mang đến một bữa cơm tuyệt vời cho gia đình bạn #gioheoham #thitlon #thitheo', 'https://img-global.cpcdn.com/recipes/160c33d89053bdb6/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25733279', 'Nước Mắm Tĩn')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', '1 cái Giò heo', 'giò heo', '1 cái', 1),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', '15 quả Vả', 'vả', '15 quả', 1),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', '2 củ Hành tím', 'hành tím', '2 củ', 1),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', '2 nhánh Hành lá', 'hành lá', '2 nhánh', 1),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', '1.5 muỗng canh Dầu ăn', 'dầu ăn', '1.5 muỗng canh', 1),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', '1 muỗng cà phê Nước mắm', 'nước mắm', '1 muỗng cà phê', 1),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', '1 củ Gừng', 'gừng', '1 củ', 1),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', '1 ít Muối hạt', 'muối hạt', '1 ít', 1),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', 'Muối/ bột ngọt/ hạt nêm', 'muối/ bột ngọt/ hạt nêm', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', 1, 'Sơ chế chân giò heo Chân giò heo bạn mang rửa sạch, cắt thành từng khoanh tròn. Bắc nồi lên bếp, cho chân giò vào nồi nước để luộc sơ, dập dập củ gừng thả vào cùng một chút muối hạt để khử bớt mùi hôi của chân giò. Khi nước sôi, bạn tắt bếp gắp chân giò ra, rửa sạch rồi đổ bỏ nước luộc đó.', 'https://img-global.cpcdn.com/steps/ce3368dd772f69e1/400x400cq80/photo.jpg'),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', 2, 'Sơ chế quả vả Quả vả bạn gọt vỏ, sau đó ngâm với nước muối cho sạch nhựa rồi cắt từng quả thành 4 miếng đều nhau.', 'https://img-global.cpcdn.com/steps/c5067194250c6a2b/400x400cq80/photo.jpg'),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', 3, 'Nấu giò heo hầm vả Bắc nồi lên bếp, cho 1.5 muỗng canh dầu ăn vào nồi, đun sôi với lửa vừa rồi thả 2 quả hành tím đã thái mỏng vào phi thơm. Sau đó, thả phần vả đã thái vào xào sơ, nêm vào nồi 1 muỗng cà phê muối, 1 muỗng cà phê hạt nêm, 1 muỗng cà phê nước mắm, đảo đều cho vả thấm gia vị. Tiếp đến, bạn tiếp tục cho giò heo vào và đảo đều khoảng 5 phút cho chân giò thấm vị rồi cho nước vào nồi đến khi ngập mặt chân giò. Hầm giò heo với vả trong khoảng 30 phút cho tới khi chín mềm thì tắt bếp.', 'https://img-global.cpcdn.com/steps/7cfabddac05110f2/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('dd294e13-8a3b-40eb-b993-8badd8ca4f65', 480, 30.0, 25.0, 24.0, 3.0, 56.4, 3.6)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', 'món ngon mỗi ngày'),
('dd294e13-8a3b-40eb-b993-8badd8ca4f65', 'dễ làm');

-- Món ăn: Thịt ba chỉ rim mặn ngọt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('f098841f-875c-4b12-9dcc-8f624b282a12', 'Thịt ba chỉ rim mặn ngọt', 'Ngày nào cũng vậy… Mở tủ lạnh ra, đứng nhìn 5 phút… rồi lại đóng vào 🤣 Thịt có. Rau có. Trứng cũng có. Nhưng câu hỏi lớn nhất vẫn là: “Nấu món gì bây giờ?” Nếu bạn cũng từng rơi vào tình cảnh này, thì hôm nay mình gợi ý một món “cứu cánh” cực nhanh – ngon – dễ làm: 🥢 THỊT BA CHỈ RIM MẶN NGỌT – ĐƯA CƠM CỰC MẠNH Nguyên liệu: 300g thịt ba chỉ 2 muỗng nước mắm 1 muỗng đường Tỏi, tiêu, ớt (tuỳ khẩu vị) Cách làm nhanh gọn: Thịt cắt miếng vừa ăn, chần sơ cho sạch Phi tỏi thơm → cho thịt vào đảo săn Thêm nước mắm + đường → rim lửa nhỏ Đến khi nước sệt lại, thịt bóng đẹp là xong Thêm chút nước dừa nếu có → vị sẽ đậm đà và “gây nghiện” hơn hẳn! Món này ăn với cơm nóng + dưa leo là “hết nồi lúc nào không biết” Nấu ăn đôi khi không cần quá cầu kỳ… Chỉ cần một món đủ ngon để cả nhà ăn hết sạch, và một bữa cơm đủ ấm để mọi người ngồi lại với nhau ❤️', 'https://img-global.cpcdn.com/recipes/232f3ef0d0042fae/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25729384', 'Nước Mắm Tĩn')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('f098841f-875c-4b12-9dcc-8f624b282a12', '300 g thịt ba chỉ', 'thịt ba chỉ', '300 g', 1),
('f098841f-875c-4b12-9dcc-8f624b282a12', '2 muỗng nước mắm', 'nước mắm', '2 muỗng', 1),
('f098841f-875c-4b12-9dcc-8f624b282a12', '1 muỗng đường', 'đường', '1 muỗng', 1),
('f098841f-875c-4b12-9dcc-8f624b282a12', 'Tỏi (tuỳ khẩu vị)', 'tỏi', 'Tùy lượng', 1),
('f098841f-875c-4b12-9dcc-8f624b282a12', 'tiêu (tuỳ khẩu vị)', 'tiêu', 'Tùy lượng', 1),
('f098841f-875c-4b12-9dcc-8f624b282a12', 'ớt (tuỳ khẩu vị)', 'ớt', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('f098841f-875c-4b12-9dcc-8f624b282a12', 1, 'Thịt cắt miếng vừa ăn, chần sơ cho sạch', 'https://img-global.cpcdn.com/steps/cf72c90696d416ec/400x400cq80/photo.jpg'),
('f098841f-875c-4b12-9dcc-8f624b282a12', 2, 'Phi tỏi thơm → cho thịt vào đảo săn', 'https://img-global.cpcdn.com/steps/8866c5181dfeef94/400x400cq80/photo.jpg'),
('f098841f-875c-4b12-9dcc-8f624b282a12', 3, 'Thêm nước mắm + đường → rim lửa nhỏ', ''),
('f098841f-875c-4b12-9dcc-8f624b282a12', 4, 'Đến khi nước sệt lại, thịt bóng đẹp là xong', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('f098841f-875c-4b12-9dcc-8f624b282a12', 480, 30.0, 25.0, 24.0, 3.0, 51.5, 4.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('f098841f-875c-4b12-9dcc-8f624b282a12', 'món ngon mỗi ngày'),
('f098841f-875c-4b12-9dcc-8f624b282a12', 'dễ làm');

-- Món ăn: Thịt ba chỉ/sườn ba chỉ kho trứng nước
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', 'Thịt ba chỉ/sườn ba chỉ kho trứng nước', 'Nấu kiểu Huế', 'https://img-global.cpcdn.com/recipes/211a29745ee7c73d/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25681009', 'Thanh Ngoc')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', '400 g thịt ba chỉ', 'thịt ba chỉ', '400 g', 1),
('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', '1 chén nước sôi để nguội', 'nước sôi để nguội', '1 chén', 1),
('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', '4 củ hành tím', 'hành tím', '4 củ', 1),
('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', '1 muỗng cafe tiêu', 'cafe tiêu', '1 muỗng', 1),
('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', '2 muỗng thìa ăn nước mắm', 'thìa ăn nước mắm', '2 muỗng', 1),
('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', '2 muỗng cafe đường đen', 'cafe đường đen', '2 muỗng', 1),
('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', '10 quả trứng cút hoặc 4 quả trứng gà', 'trứng cút hoặc 4 quả trứng gà', '10 quả', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', 1, 'Sơ chế nguyên liệu: Thịt sơ chế rửa muối cắt lát để khô ráo. Trứng luộc lọt vỏ để sẵn. Hành tím lọt vỏ thái mỏng', ''),
('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', 2, 'Nấu: bắt chảo thêm ít dầu và thịt đảo cho chín khoảng 5 phút, sau đó cho hành tím vào đảo đều tiếp khoảng 2 phút. Tiếp tục cho gia vị nước mắm, đường, tiêu và 1 chén nước sôi để nguội + Trứng + hạ nhỏ lửa mức trung bình 6-7 để kho thịt tiếp khoảng 37 phút. Tổng thời gian nấu 45 phút.', 'https://img-global.cpcdn.com/steps/eb798457d7cd5241/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', 480, 30.0, 25.0, 24.0, 3.0, 61.3, 4.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('edfe4443-d230-4dba-b2c0-d5ebcc59b29c', 'món kho');

-- Món ăn: Chân giò hầm Hàn Quốc
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Chân giò hầm Hàn Quốc', '🤤', 'https://img-global.cpcdn.com/recipes/4b46ed2a93d03e05/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25618050', 'Ngọc Huyền')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 chân giò heo lớn (khoảng 1,4 đến 2,3 kg)', 'chân giò heo lớn', '1', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 muỗng canh gừng thái lát', 'gừng thái lát', '1 muỗng canh', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '10 cốc nước', 'cốc nước', '10', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 quả táo thái miếng', 'táo thái miếng', '1 quả', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 cây hành baro xắt khúc', 'hành baro xắt khúc', '1 cây', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 củ hành tây xắt khúc', 'hành tây xắt khúc', '1 củ', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '8 quả táo tàu', 'táo tàu', '8 quả', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '5,6 nhánh tỏi cắt đôi', 'tỏi cắt đôi', '5,6 nhánh', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 nhánh gừng đã gọt vỏ, thái mỏng', 'gừng đã gọt vỏ, thái mỏng', '1 nhánh', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '4,5 nhánh hành lá xắt khúc', 'hành lá xắt khúc', '4,5 nhánh', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 hoa hồi to', 'hoa hồi to', '1', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 thanh quế', 'thanh quế', '1', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 thìa cà phê hạt tiêu đen nguyên hạt', 'hạt tiêu đen nguyên hạt', '1 thìa cà phê', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 thìa canh cà phê đen hoà tan', 'cà phê đen hoà tan', '1 thìa canh', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '2 muỗng canh tương đậu lên men HQ', 'tương đậu lên men hq', '2 muỗng canh', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1/4 chén rượu nấu ăn mirin', 'rượu nấu ăn mirin', '1/4 chén', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1/3 chén nước tương', 'nước tương', '1/3 chén', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1/4 cốc đường nâu', 'cốc đường nâu', '1/4', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 muỗng canh muối', 'muối', '1 muỗng canh', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1/2 chén siro gạo', 'siro gạo', '1/2 chén', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Tương trộn Ssamjang', 'tương trộn ssamjang', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Dấm', 'dấm', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Đường', 'đường', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Dầu mè', 'dầu mè', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Coca or 7up', 'coca or 7up', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Hạt mè', 'hạt mè', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Tương trộn Ssamjang', 'tương trộn ssamjang', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Đường', 'đường', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Tỏi ớt băm nhỏ', 'tỏi ớt băm nhỏ', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Coca or 7up', 'coca or 7up', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '15 gr tương đậu', 'r tương đậu', '15 g', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '15 gr tương ớt Gochujang', 'r tương ớt gochujang', '15 g', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '15 gr mật ong', 'r mật ong', '15 g', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Tỏi xay', 'tỏi xay', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Dầu mè', 'dầu mè', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Hạt mè đập giập', 'hạt mè đập giập', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '2 muỗng nước thịt', 'nước thịt', '2 muỗng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 muỗng canh tôm muối lên men', 'tôm muối lên men', '1 muỗng canh', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '2 muỗng canh nước', 'nước', '2 muỗng canh', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Tỏi băm nhỏ, hành lá thái nhỏ', 'tỏi băm nhỏ, hành lá thái nhỏ', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1/2 thìa cà phê đường', 'đường', '1/2 thìa cà phê', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 thìa cà phê bột ớt HQ', 'bột ớt hq', '1 thìa cà phê', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', '1 nhúm tiêu xay', 'nhúm tiêu xay', '1', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Mè rang', 'mè rang', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Lá vừng HQ', 'lá vừng hq', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Cải thảo', 'cải thảo', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Xà lách', 'xà lách', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Kim chi', 'kim chi', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'lát Tỏi thái', 'lát tỏi thái', 'Tùy lượng', 1),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'Dầu mè và hạt mè', 'dầu mè và hạt mè', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 1, 'Chân giò heo rửa sạch ngâm với nước muối dấm loãng 30'' rồi rửa lại tiếp với nước. Cho chân giò heo và 1 muỗng canh gừng thái mỏng vào. Đậy nắp và đun sôi trong 20 đến 25 phút trên lửa vừa, cho đến khi sôi mạnh. Nhấc nồi ra khỏi bếp. Vớt chân giò ra và rửa sạch bằng nước lạnh với bàn chải nhà bếp. Rửa sạch cả nồi nữa. Đặt nồi trở lại bếp và cho chân giò vào trong.', ''),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 2, 'Cho các nguyên liệu hầm vào nồi. Cho 10 cốc nước rồi đậy nắp và nấu trong 1 giờ ở lửa vừa lớn. Mở nắp và lật ngược chân giò.', ''),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 3, 'Giảm lửa xuống mức trung bình, đậy nắp và nấu thêm một tiếng nữa. Kiểm tra xem thịt đã chín kỹ chưa bằng cách dùng đũa thép không gỉ hoặc xiên gỗ dài chọc vào. Nếu xiên xuyên qua dễ dàng và thịt gần như bong ra khỏi xương, nghĩa là thịt đã chín kỹ. Nếu chưa, hãy nấu thêm và thêm nước nếu cần. Tăng nhiệt độ lên mức cao và nấu thêm 10 phút nữa mà không đậy nắp.', ''),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 4, 'Lấy chân giò ra và đặt lên thớt. Để nguội tầm 30'' hoặc cho vào trong tủ lạnh cho thịt được săn lại.', ''),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 5, 'Tuỳ chọn loại sốt muốn ăn mà pha ra bát.', ''),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 6, 'Thái thịt thành miếng vừa ăn xếp ra đĩa. Rắc hạt mè trang trí bên trên.', 'https://img-global.cpcdn.com/steps/e5de818105e387cc/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 480, 30.0, 31.0, 24.0, 6.5, 45.6, 2.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'món ngon mỗi ngày'),
('96f51ebf-f0cd-4035-bc65-c94dff0e50ba', 'dễ làm');

-- Món ăn: Giò heo đông cô
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('95c79921-d443-4903-94da-a89bfe72b3f9', 'Giò heo đông cô', 'Cách làm món Giò heo đông cô ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/215edffa7d51220c/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25580797', 'Uyen Ngoc Bui')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('95c79921-d443-4903-94da-a89bfe72b3f9', '50 g nấm đông cô', 'nấm đông cô', '50 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '2 kg giò heo', 'giò heo', '2 kg', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '4 Tai vị', 'tai vị', '4', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '4 Đinh Hương :', 'đinh hương', '4', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '2 quả Thảo quả đập dập', 'thảo quả đập dập', '2 quả', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '5 Lá thơm :', 'á thơm', '5 L', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '20 g đường phèn', 'đường phèn', '20 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '10 g đường cát', 'đường cát', '10 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '40 g bột anh Aone', 'bột anh aone', '40 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '20 g bột ngọt', 'bột ngọt', '20 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '5 g Muối canh', 'muối canh', '5 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '40 g đường cát', 'đường cát', '40 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '20 g bột ngọt', 'bột ngọt', '20 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '30 g bột nêm', 'bột nêm', '30 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '30 g gừng', 'gừng', '30 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '40 g hành lá', 'hành lá', '40 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '400 g nước lạnh', 'nước lạnh', '400 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '10 g bột ngọt', 'bột ngọt', '10 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '40 g đường cát', 'đường cát', '40 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '70 g dầu hào', 'dầu hào', '70 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '20 g hạt nêm', 'hạt nêm', '20 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '1 g dầu mè', 'dầu mè', '1 g', 1),
('95c79921-d443-4903-94da-a89bfe72b3f9', '5 g hắc xì dầu dầu', 'hắc xì dầu dầu', '5 g', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('95c79921-d443-4903-94da-a89bfe72b3f9', 1, 'Sơ chế giò heo: -Giò heo mua về thui sạch bằng dụng cụ khè hoặc gaz, hoặc than củi.. Vv -Cạo rửa sạch sẽ lớp đen, chẻ giò heo -Xoa rượu trắng, dầu hào tạo màu.', ''),
('95c79921-d443-4903-94da-a89bfe72b3f9', 2, 'Chiên cho giò heo săn lại', ''),
('95c79921-d443-4903-94da-a89bfe72b3f9', 3, 'Công thức nước hấp : Rang thơm : -Tai vị : 4 -Đinh Hương : 4 - Thảo quả đập dập : 2 - Lá thơm : 5 -Cho vào 1 lít nước -Gia vị : -20g đường phèn -10g đường cát -40g bột anh Aone -20g bột ngọt Cách hấp -Hấp chân giò chặt nhỏ : 60p -Chân giò nguyên cái : 1 tiếng5 đến 2tiếng5 tùy nhu cầu thích vừa mềm hay thật mềm (lâu lâu trở chân giò cho thấm, nhớ châm nước hấp tránh cháy nồi)', ''),
('95c79921-d443-4903-94da-a89bfe72b3f9', 4, '50g nấm đông cô đã ngâm, vắt nước, bóp với 50g bột năng cho nấm hết chát, rửa sạch, để ráo. - Nước luộc nấm đông cô 1 lit3 nước nấu sôi cho nấm đông cô vào nấu với lửa lớn 2 phút nêm gia vị : 5g Muối canh 40g đường cát 20g bột ngọt 30g bột nêm 30g gừng 40g hành lá -Nấu sôi lại cho 50g rượu hoa tiêu, 50g dầu ăn, vặn lửa liu riu 40p -Cho cà rốt vào luộc cùng nấm, đến khi cà rốt chín thì tắt lửa.', ''),
('95c79921-d443-4903-94da-a89bfe72b3f9', 5, 'Sốt dầu hào, luộc rau cải thìa trang trí. 400g nước lạnh 10g bột ngọt 40g đường cát 70g dầu hào 20g hạt nêm 1 g dầu mè 5g hắc xì dầu dầu Tạo sệt : 15g bột năng pha 30g nước lạnh Thích nước sốt nhiều thì tăng gấp 2.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('95c79921-d443-4903-94da-a89bfe72b3f9', 420, 30.0, 31.0, 20.0, 6.5, 55.0, 3.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('95c79921-d443-4903-94da-a89bfe72b3f9', 'món ngon mỗi ngày'),
('95c79921-d443-4903-94da-a89bfe72b3f9', 'dễ làm');

-- Món ăn: Thịt heo ngâm mắm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('53a2c2a3-8938-488d-957f-e3be16236c30', 'Thịt heo ngâm mắm', 'Cách làm món Thịt heo ngâm mắm ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/82d4a49a71d034a9/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25580771', 'Uyen Ngoc Bui')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('53a2c2a3-8938-488d-957f-e3be16236c30', '2 kg thịt heo hoặc thịt chân giò cắt miếng', 'thịt heo hoặc thịt chân giò cắt miếng', '2 kg', 1),
('53a2c2a3-8938-488d-957f-e3be16236c30', '1 lit nước mắm ngon', 'it nước mắm ngon', '1 l', 1),
('53a2c2a3-8938-488d-957f-e3be16236c30', '500 g đường vàng', 'đường vàng', '500 g', 1),
('53a2c2a3-8938-488d-957f-e3be16236c30', '200 g Ớt nhiều loại :', 'ớt nhiều loại', '200 g', 1),
('53a2c2a3-8938-488d-957f-e3be16236c30', '500 g đường cát hoặc đường phèn loại nhuyễn', 'đường cát hoặc đường phèn loại nhuyễn', '500 g', 1),
('53a2c2a3-8938-488d-957f-e3be16236c30', '2 m súp tiêu sọ đen rang thơm', 'm súp tiêu sọ đen rang thơm', '2', 1),
('53a2c2a3-8938-488d-957f-e3be16236c30', '10 củ tỏi cắt lát', 'tỏi cắt lát', '10 củ', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('53a2c2a3-8938-488d-957f-e3be16236c30', 1, 'Thịt heo hoặc thịt chân giò cắt miếng. Rửa sạch bằng Muối, giấm, lau khô', ''),
('53a2c2a3-8938-488d-957f-e3be16236c30', 2, 'Vớt Thịt ra, lấy phần nước đường ướp thịt cho vào phần nước mắm và phần đường nấu sôi', ''),
('53a2c2a3-8938-488d-957f-e3be16236c30', 3, 'Nấu sôi lại nước mắm cho các loại ớt, tỏi đã sấy khô, tiêu xanh, tiêu đen vào. Nấu 5p tắt lửa', ''),
('53a2c2a3-8938-488d-957f-e3be16236c30', 4, 'Bỏ thịt vào ngâm', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('53a2c2a3-8938-488d-957f-e3be16236c30', 480, 30.0, 25.0, 24.0, 3.0, 38.3, 1.6)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('53a2c2a3-8938-488d-957f-e3be16236c30', 'món ngon mỗi ngày'),
('53a2c2a3-8938-488d-957f-e3be16236c30', 'dễ làm');

-- Món ăn: Canh súp lơ sườn heo nấu miến
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('2427ca27-438b-43f3-a75d-5fb67304c53b', 'Canh súp lơ sườn heo nấu miến', 'Món canh ăn cơm hàng ngày mà nấu ăn sáng cũng được.', 'https://img-global.cpcdn.com/recipes/58919815d957815d/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/25377922', 'Khanh Tran')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('2427ca27-438b-43f3-a75d-5fb67304c53b', '400 gr xương / sườn heo', 'r xương / sườn heo', '400 g', 1),
('2427ca27-438b-43f3-a75d-5fb67304c53b', '1 bông súp lơ trắng', 'bông súp lơ trắng', '1', 1),
('2427ca27-438b-43f3-a75d-5fb67304c53b', '50 gr miến dong', 'r miến dong', '50 g', 1),
('2427ca27-438b-43f3-a75d-5fb67304c53b', 'gia vị nêm: muối, bột ngọt, hành lá, tiêu', 'gia vị nêm', 'muối, bột ngọt, hành lá, tiêu', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('2427ca27-438b-43f3-a75d-5fb67304c53b', 1, 'Rửa sườn, để ráo. Cắt bông cải thành từng bông nhỏ vừa ăn, rửa nước, để ráo. Miến dong ngâm nước lạnh chừng 3-5 phút, vớt ra rá.', ''),
('2427ca27-438b-43f3-a75d-5fb67304c53b', 2, 'Nấu nồi nước sôi, cho sườn và hành tím bằm vào. Canh sôi, nêm muối, bột ngọt, hạ nhỏ lửa, hầm xương liu riu chừng 20 phút. Tắt bếp để xương tự ủ trong nồi.', 'https://img-global.cpcdn.com/steps/aaa6e2c3607e8a50/400x400cq80/photo.jpg'),
('2427ca27-438b-43f3-a75d-5fb67304c53b', 3, 'Sau khi ủ thêm khoảng 15-30 phút. Bật bếp lên lại, cho súp lơ vào, khi canh sôi chừng 3 phút, thả miến vào, nêm lại. Nấu thêm vài phút rồi tắt bếp. Ủ thêm vài phút rồi múc ra tô.', 'https://img-global.cpcdn.com/steps/851310d7864ad752/400x400cq80/photo.jpg'),
('2427ca27-438b-43f3-a75d-5fb67304c53b', 4, 'Thêm hành lá, rắc tí tiêu. Ăn thôi.', 'https://img-global.cpcdn.com/steps/fb07e44958ffe75b/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('2427ca27-438b-43f3-a75d-5fb67304c53b', 420, 30.0, 25.0, 20.0, 3.0, 50.3, 3.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('2427ca27-438b-43f3-a75d-5fb67304c53b', 'món nước');

-- Món ăn: Ba Rọi Kho Tép Đất
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('c93a3249-9b81-45e6-b0f9-a3b822a43823', 'Ba Rọi Kho Tép Đất', 'Cơm nhà chuẩn vị miền Tây với ba rọi kho tép, vỏ giòn, béo thơm, ngọt ngọt kẹo kẹo ăn cùng cơm với canh khoai mỡ siêu ngon.', 'https://img-global.cpcdn.com/recipes/c673e67f86edf074/1200x630cq80/photo.jpg', 30, 'Trung bình', '5-6 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25345147', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('c93a3249-9b81-45e6-b0f9-a3b822a43823', '200 g Thịt ba rọi', 'thịt ba rọi', '200 g', 1),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', '300 g Tép đất', 'tép đất', '300 g', 1),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', '2 củ Hành tím', 'hành tím', '2 củ', 1),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', '3 tép Tỏi', 'tỏi', '3 tép', 1),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', '1 muỗng canh Dầu điều', 'dầu điều', '1 muỗng canh', 1),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', '2 muỗng canh Nước mắm', 'nước mắm', '2 muỗng canh', 1),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', '2.5 muỗng canh đường', 'đường', '2.5 muỗng canh', 1),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', '1/2 muỗng cà phê Tiêu xay', 'tiêu xay', '1/2 muỗng cà phê', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('c93a3249-9b81-45e6-b0f9-a3b822a43823', 1, 'Tép đất rửa sạch, để ráo, ướp với hành tỏi băm nhỏ.', 'https://img-global.cpcdn.com/steps/307e26ee888ae807/400x400cq80/photo.jpg'),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', 2, 'Thịt ba rọi xắt miếng vừa ăn, ướp với hành tỏi băm.', 'https://img-global.cpcdn.com/steps/8d1cbe8c004614fb/400x400cq80/photo.jpg'),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', 3, 'Làm nóng chảo, cho thịt vào xào cho săn lại. Tươm mỡ bớt thì múc bớt mỡ ra.', 'https://img-global.cpcdn.com/steps/b56630b69c186daf/400x400cq80/photo.jpg'),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', 4, 'Thêm tép vào xào chung đến khi tép chuyển màu.', 'https://img-global.cpcdn.com/steps/aeb0dc76252db4dc/400x400cq80/photo.jpg'),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', 5, 'Thêm dầu điều, đảo đều cho lên màu đẹp.', ''),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', 6, 'Rưới nước mắm, kho nhỏ lửa cho thấm vị.', 'https://img-global.cpcdn.com/steps/a62bed1455331a2d/400x400cq80/photo.jpg'),
('c93a3249-9b81-45e6-b0f9-a3b822a43823', 7, 'Rắc tiêu xay lên trên trước khi tắt bếp.', 'https://img-global.cpcdn.com/steps/992b3e7197e4f1aa/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('c93a3249-9b81-45e6-b0f9-a3b822a43823', 300, 15.0, 25.0, 10.0, 3.0, 35.4, 2.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('c93a3249-9b81-45e6-b0f9-a3b822a43823', 'món kho');

-- Món ăn: Thịt nạc vai hầm táo (Stewed Meat with Apples)
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('a6438edd-496e-4f70-a262-0a62bf0e5023', 'Thịt nạc vai hầm táo (Stewed Meat with Apples)', 'Món thịt hầm táo, mềm mại, thơm ngon,. Có thể ăn cùng bánh mì hay cơm đều được', 'https://img-global.cpcdn.com/recipes/550326816bbab656/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 people', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25548273', 'Minh Hayes')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('a6438edd-496e-4f70-a262-0a62bf0e5023', '500 gr thịt nạc vai', 'r thịt nạc vai', '500 g', 1),
('a6438edd-496e-4f70-a262-0a62bf0e5023', '1 trái táo', 'táo', '1 trái', 1),
('a6438edd-496e-4f70-a262-0a62bf0e5023', '1 củ hành tây', 'hành tây', '1 củ', 1),
('a6438edd-496e-4f70-a262-0a62bf0e5023', '3 củ hành tím, ít tỏi bằm', 'hành tím, ít tỏi bằm', '3 củ', 1),
('a6438edd-496e-4f70-a262-0a62bf0e5023', '1/2 cup rượu nấu ăn', 'cup rượu nấu ăn', '1/2', 1),
('a6438edd-496e-4f70-a262-0a62bf0e5023', '1 tbsp garlic, pepper seasoning', 'garlic, pepper seasoning', '1 tbsp', 1),
('a6438edd-496e-4f70-a262-0a62bf0e5023', '2 tsp muối', 'muối', '2 tsp', 1),
('a6438edd-496e-4f70-a262-0a62bf0e5023', '2 tsp bột quế (cinnamon)', 'bột quế', '2 tsp', 1),
('a6438edd-496e-4f70-a262-0a62bf0e5023', '2 lá thơm (bay leaves)', 'á thơm', '2 l', 1),
('a6438edd-496e-4f70-a262-0a62bf0e5023', '2 tbsp nước tương', 'nước tương', '2 tbsp', 1),
('a6438edd-496e-4f70-a262-0a62bf0e5023', '1 tbsp đường nâu', 'đường nâu', '1 tbsp', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('a6438edd-496e-4f70-a262-0a62bf0e5023', 1, 'Thịt nạc lựa phần có tý mỡ, cắt từng miếng mỏng dài, đoạn ướp tý muối, tiêu, đường, tỏi bằm. Trộn đều vừa trộn vừa massage cho miếng thịt được thấm mềm. Hành tây, táo cắt múi cam.', 'https://img-global.cpcdn.com/steps/70004d5a3c07ec2e/400x400cq80/photo.jpg'),
('a6438edd-496e-4f70-a262-0a62bf0e5023', 2, 'Thịt ướp ngấm khoảng 10'' thì cho vào chảo chiên vàng 2 mặt', 'https://img-global.cpcdn.com/steps/0903398daddfc259/400x400cq80/photo.jpg'),
('a6438edd-496e-4f70-a262-0a62bf0e5023', 3, 'Cho dầu phi hành tím, ít hành tây cho thơm, kế xếp thịt vào cùng táo và hành tây còn lại, đun sơ, đoạn cho rượu vào. Khi sôi, cho thêm 1 cup nước lọc,', 'https://img-global.cpcdn.com/steps/1e7e819af53fc16f/400x400cq80/photo.jpg'),
('a6438edd-496e-4f70-a262-0a62bf0e5023', 4, 'Đun khi sôi rồi nêm nếm lại cho vừa miệng, kế đậy nắp đun cho đến khi hơi sanh sánh lại', 'https://img-global.cpcdn.com/steps/2d4b2085786e7080/400x400cq80/photo.jpg'),
('a6438edd-496e-4f70-a262-0a62bf0e5023', 5, 'Dọn ăn kèm với bánh mì hay cơm.', 'https://img-global.cpcdn.com/steps/b5b0bdcbecb3cce2/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('a6438edd-496e-4f70-a262-0a62bf0e5023', 300, 15.0, 25.0, 10.0, 3.0, 77.1, 1.6)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('a6438edd-496e-4f70-a262-0a62bf0e5023', 'món ngon mỗi ngày'),
('a6438edd-496e-4f70-a262-0a62bf0e5023', 'dễ làm');

-- Món ăn: Thịt ba chỉ sốt tỏi Hàn Quốc
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('26c7eef6-e138-4f5b-b03a-4484ad11595f', 'Thịt ba chỉ sốt tỏi Hàn Quốc', 'Món này đậm mùi tỏi rất thơm và bắt cơm', 'https://img-global.cpcdn.com/recipes/0870c150504972a3/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25503073', 'Yuri')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '500 g Thịt ba chỉ', 'thịt ba chỉ', '500 g', 1),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '1 chút Gốc hành baro', 'gốc hành baro', '1 chút', 1),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '1 quả Ớt tươi', 'ớt tươi', '1 quả', 1),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '5 thìa ăn cơm Tỏi băm (đặc điểm của món này là thật nhiều tỏi)', 'ăn cơm tỏi băm', '5 thìa', 1),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '3 thìa ăn cơm Bột ớt', 'ăn cơm bột ớt', '3 thìa', 1),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '3 thìa ăn cơm Nước tương Hàn Quốc (진간장)', 'ăn cơm nước tương hàn quốc', '3 thìa', 1),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '0.5 thìa ăn cơm Dầu hào (굴소스)', 'ăn cơm dầu hào', '0.5 thìa', 1),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '0.5 thìa ăn cơm Tương đậu Hàn Quốc (된장)', 'ăn cơm tương đậu hàn quốc', '0.5 thìa', 1),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '2 thìa ăn cơm Rượu nấu ăn', 'ăn cơm rượu nấu ăn', '2 thìa', 1),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '2 thìa ăn cơm Đường', 'ăn cơm đường', '2 thìa', 1),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', '1/2 thìa cà phê Tiêu', 'tiêu', '1/2 thìa cà phê', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('26c7eef6-e138-4f5b-b03a-4484ad11595f', 1, 'Thịt ba chỉ rửa sạch, để ráo, cắt miếng vừa ăn.', 'https://img-global.cpcdn.com/steps/f419e83256f775c6/400x400cq80/photo.jpg'),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', 2, 'Làm nóng chảo, cho thịt vào áp chảo lửa to đến khi vàng đều hai mặt.', 'https://img-global.cpcdn.com/steps/f6af1c4189ffedef/400x400cq80/photo.jpg'),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', 3, 'Cho hành baro vào xào cùng thịt cho thơm, rồi đổ hỗn hợp gia vị ghi trên phần ghi chú vào.', 'https://img-global.cpcdn.com/steps/5572d88c717416a0/400x400cq80/photo.jpg'),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', 4, 'Đảo đều trên lửa vừa nhỏ 2-3 phút cho ra dầu ớt, rồi thêm nước lọc, đun đến khi sốt sệt lại.', 'https://img-global.cpcdn.com/steps/441c91f9426a67da/400x400cq80/photo.jpg'),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', 5, 'Thêm tiêu và ớt tươi, đảo đều rồi tắt bếp. Không đun cạn quá để thịt mềm ẩm.', 'https://img-global.cpcdn.com/steps/739f3e50438ad762/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('26c7eef6-e138-4f5b-b03a-4484ad11595f', 600, 30.0, 55.0, 24.0, 3.0, 63.7, 2.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('26c7eef6-e138-4f5b-b03a-4484ad11595f', 'món ngon mỗi ngày'),
('26c7eef6-e138-4f5b-b03a-4484ad11595f', 'dễ làm');

-- Món ăn: Thịt Ba Chỉ Hầm Tảo Biển Hàn Quốc
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('0eb25cae-0ea3-41c3-8eef-c72593725910', 'Thịt Ba Chỉ Hầm Tảo Biển Hàn Quốc', 'Món này ăn vị hơi giống thịt chân giò hầm của Hàn Quốc, mà cũng hơi hơi giống thịt kho tàu của Việt Nam, ăn rất cuốn. Có thể dùng nồi áp suất ninh cho nhanh, nhưng mình thấy ninh từ từ thì thịt ngon và thấm hơn ( nhưng tốn tiền điện 🤣🤣🤣)', 'https://img-global.cpcdn.com/recipes/041d89587d17407e/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25470002', 'Yuri')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('0eb25cae-0ea3-41c3-8eef-c72593725910', '800 g Thịt ba chỉ', 'thịt ba chỉ', '800 g', 1),
('0eb25cae-0ea3-41c3-8eef-c72593725910', '50 g (ngâm nở) Tảo biển khô', 'tảo biển khô', '50 g', 1),
('0eb25cae-0ea3-41c3-8eef-c72593725910', '30 g (ngâm nở) Mộc nhĩ (có thẻ lược bỏ)', 'mộc nhĩ', '30 g', 1),
('0eb25cae-0ea3-41c3-8eef-c72593725910', '1/2 củ (cắt múi cau) Hành tây', 'hành tây', '1/2 củ', 1),
('0eb25cae-0ea3-41c3-8eef-c72593725910', '1/3 cây (cắt khúc) Hành baro', 'hành baro', '1/3 cây', 1),
('0eb25cae-0ea3-41c3-8eef-c72593725910', '15 tép (bóc vỏ) Tỏi', 'tỏi', '15 tép', 1),
('0eb25cae-0ea3-41c3-8eef-c72593725910', '2 nhánh Tiêu xanh', 'tiêu xanh', '2 nhánh', 1),
('0eb25cae-0ea3-41c3-8eef-c72593725910', 'Gốc hành ta (có thể lược bỏ)', 'gốc hành ta', 'Tùy lượng', 1),
('0eb25cae-0ea3-41c3-8eef-c72593725910', 'Gia vị: 3 thìa nước tương nấu canh HQ 국간장, 3 thìa nước tương 진간장, 1 thìa dầu hào 굴소스, 2 thìa nước đường mạch nha 물엿, 4 thìa rượu nấu ăn (có thể dùng rượu soju)', 'gia vị', '3 thìa nước tương nấu canh HQ 국간장, 3 thìa nước tương 진간장, 1 thìa dầu hào 굴소스, 2 thìa nước đường mạch nha 물엿, 4 thìa rượu nấu ăn (có thể dùng rượu soju)', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('0eb25cae-0ea3-41c3-8eef-c72593725910', 1, 'Thịt ba chỉ rửa sạch, lau khô, áp chảo cho vàng đều 2 mặt.', 'https://img-global.cpcdn.com/steps/5f93f24d4c9f3187/400x400cq80/photo.jpg'),
('0eb25cae-0ea3-41c3-8eef-c72593725910', 2, 'Cho hành baro, tỏi, hành tây, ớt xanh, tiêu xanh vào đảo cùng thịt cho thơm.', 'https://img-global.cpcdn.com/steps/01554422cd05cb4a/400x400cq80/photo.jpg'),
('0eb25cae-0ea3-41c3-8eef-c72593725910', 3, 'Đổ nước ngâm tảo biển và thêm nước lọc cho ngập thịt, cho hết hỗn hợp gia vị như phần nguyên liệu ghi trên vào, rải tảo biển lên trên cùng đun sôi, hớt bọt, hạ nhỏ lửa hầm 1 tiếng.m(tuỳ độ mềm muốn ăn, mình thích ăn mềm như thịt ninh nhừ nên ninh khoảng 1 tiếng10p). Lúc này chưa bỏ mục nhĩ nha', 'https://img-global.cpcdn.com/steps/843627605937d838/400x400cq80/photo.jpg'),
('0eb25cae-0ea3-41c3-8eef-c72593725910', 4, 'Khoảng 30p lật miếng thịt lại cho chín đều, đậy vung cho nhanh nhừ. Giữa chừng nếu cạn nước thịt cho thêm nước vào. Mình để ảnh gia vị bên dưới. Khoảng 5p trước khi tắt bếp cho mục nhĩ đã ngâm vào đun cùng', 'https://img-global.cpcdn.com/steps/4c28e8014651b65c/400x400cq80/photo.jpg'),
('0eb25cae-0ea3-41c3-8eef-c72593725910', 5, 'Đun đến khi nước sệt lại còn 1 chút, Thịt chín mềm, vớt ra thái lát, xếp ra đĩa cùng tảo biển, mộc nhĩ cắt miếng vừa ăn. Dưới chút nước sốt hầm thịt lên trên và thưởng thức. Ăn cùng kim chi cũng rất ngon.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('0eb25cae-0ea3-41c3-8eef-c72593725910', 480, 30.0, 25.0, 24.0, 3.0, 70.2, 3.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('0eb25cae-0ea3-41c3-8eef-c72593725910', 'món ngon mỗi ngày'),
('0eb25cae-0ea3-41c3-8eef-c72593725910', 'dễ làm');

-- Món ăn: Thịt heo xào lá quế Pad Kra Pao
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 'Thịt heo xào lá quế Pad Kra Pao', 'Rất dễ nấu mà rất ngon luôn nhen #ChongNganSauTet', 'https://img-global.cpcdn.com/recipes/924fdad4219c6bf2/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/25452407', 'Loan Ly')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', '500 g thịt băm', 'thịt băm', '500 g', 1),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', '1 bó lá quế', 'lá quế', '1 bó', 1),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', '2 muỗng canh dầu hào', 'dầu hào', '2 muỗng canh', 1),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', '2 muỗng canh xì dầu', 'xì dầu', '2 muỗng canh', 1),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', '1 muỗng canh đường', 'đường', '1 muỗng canh', 1),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', '1 muỗng canh nước mắm', 'nước mắm', '1 muỗng canh', 1),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 'Vài tép tỏi', 'vài tép tỏi', 'Tùy lượng', 1),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', '2-3 trái ớt', 'ớt', '2-3 trái', 1),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', '1/2 trái chanh', 'chanh', '1/2 trái', 1),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', '2 muỗng canh dầu ăn', 'dầu ăn', '2 muỗng canh', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 1, 'Ướp thịt với 1 muỗng canh dầu ăn + 1 muỗng canh dầu hào trong 15 phút', 'https://img-global.cpcdn.com/steps/419c9551b3859813/400x400cq80/photo.jpg'),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 2, 'Pha sốt gồm 1 muỗng canh nước mắm + 1 muỗng canh dầu hào + 2 muỗng canh xì dầu + 1 muỗng canh đường', 'https://img-global.cpcdn.com/steps/f0123270bccf5b1e/400x400cq80/photo.jpg'),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 3, 'Nhặt rau rồi rửa sạch, chừa riêng 1 ít để trang trí. Tỏi ớt băm nhuyễn', 'https://img-global.cpcdn.com/steps/727f6254798c58e0/400x400cq80/photo.jpg'),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 4, 'Phi thơm tỏi ớt với 1 muỗng canh dầu ăn, cho thịt vào xào cho đến khi thịt săn lại', 'https://img-global.cpcdn.com/steps/8efc97e47e056aa3/400x400cq80/photo.jpg'),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 5, 'Cho nước sốt vào đảo đều cho đến khi khô nước', 'https://img-global.cpcdn.com/steps/b2c47ee528a8a123/400x400cq80/photo.jpg'),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 6, 'Cho lá quế vào đảo nhanh rồi tắt bếp', 'https://img-global.cpcdn.com/steps/e36e5d7de2e48f50/400x400cq80/photo.jpg'),
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 7, 'Trước khi bày ra dĩa, trang trí 1 ít lá quế cho đẹp mắt. Khi ăn vắt chanh rồi trộn đều', 'https://img-global.cpcdn.com/steps/bbf1f9194c00a4fb/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 480, 30.0, 25.0, 24.0, 3.0, 40.7, 3.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('d4f17af7-c3a5-4092-b46a-c73e3ad9f87d', 'món xào');

-- Món ăn: Măng Kho Thịt Ba Chỉ
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('bc30824d-0489-4af2-985f-516a12d5a7f5', 'Măng Kho Thịt Ba Chỉ', 'Cơm nhà ngày tết có món măng kho. Măng ngấm nước thịt ăn ngon, mọi người gắp măng lia lịa. #beptetvinha', 'https://img-global.cpcdn.com/recipes/9af7e75ec9f2bb1a/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-3 phần', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25362062', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('bc30824d-0489-4af2-985f-516a12d5a7f5', '200 g Thịt ba chỉ', 'thịt ba chỉ', '200 g', 1),
('bc30824d-0489-4af2-985f-516a12d5a7f5', '200 g Măng khô đã sơ chế', 'măng khô đã sơ chế', '200 g', 1),
('bc30824d-0489-4af2-985f-516a12d5a7f5', '200 ml Nước dừa tươi', 'nước dừa tươi', '200 ml', 1),
('bc30824d-0489-4af2-985f-516a12d5a7f5', '2 muỗng canh Nước mắm', 'nước mắm', '2 muỗng canh', 1),
('bc30824d-0489-4af2-985f-516a12d5a7f5', '1/2 muỗng cà phê Tiêu xay', 'tiêu xay', '1/2 muỗng cà phê', 1),
('bc30824d-0489-4af2-985f-516a12d5a7f5', '2 nhánh Hành lá', 'hành lá', '2 nhánh', 1),
('bc30824d-0489-4af2-985f-516a12d5a7f5', '1 muỗng canh Dầu ăn', 'dầu ăn', '1 muỗng canh', 1),
('bc30824d-0489-4af2-985f-516a12d5a7f5', '1 muỗng cà phê Hành tím băm', 'hành tím băm', '1 muỗng cà phê', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('bc30824d-0489-4af2-985f-516a12d5a7f5', 1, 'Măng khô ngâm nước vo gạo qua đêm, luộc mềm 2-3 lần, xé sợi vừa ăn. Xem cách làm chi tiết đính kèm.', 'https://img-global.cpcdn.com/steps/8edc11cfd8641c0e/400x400cq80/photo.jpg'),
('bc30824d-0489-4af2-985f-516a12d5a7f5', 2, 'Thịt ba chỉ cắt miếng vừa, ướp nước mắm, tiêu, hành tím băm 15 phút.', ''),
('bc30824d-0489-4af2-985f-516a12d5a7f5', 3, 'Phi thơm hành tím, cho thịt vào xào săn.', 'https://img-global.cpcdn.com/steps/7d7b0f1fccd5d88d/400x400cq80/photo.jpg'),
('bc30824d-0489-4af2-985f-516a12d5a7f5', 4, 'Thêm măng vào xào chung, đảo đều.', 'https://img-global.cpcdn.com/steps/5e0d0d9f70cb54d9/400x400cq80/photo.jpg'),
('bc30824d-0489-4af2-985f-516a12d5a7f5', 5, 'Đổ nước dừa, kho lửa nhỏ đến khi thịt và măng mềm, nước sánh lại.', 'https://img-global.cpcdn.com/steps/570d3c4dd2ba8ec0/400x400cq80/photo.jpg'),
('bc30824d-0489-4af2-985f-516a12d5a7f5', 6, 'Rắc hành lá, tiêu xay lên trên, dùng nóng.', 'https://img-global.cpcdn.com/steps/af604838aaa12fef/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('bc30824d-0489-4af2-985f-516a12d5a7f5', 480, 30.0, 25.0, 24.0, 3.0, 79.8, 2.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('bc30824d-0489-4af2-985f-516a12d5a7f5', 'món kho');

-- Món ăn: Ba chỉ rô ti
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', 'Ba chỉ rô ti', 'Hồi nhỏ đến Tết là má làm thịt ba chỉ rô ti cho ăn. Má nấu đơn giản có vài nguyên liệu thôi mà ngon lắm. Món này ăn kèm củ kiệu chua ngọt, nhắm bia, cuộn rau sống, cuốn bánh tráng hay ăn với cơm xôi đều ngon. Ăn kiểu gì cũng thấy hợp. #BepTetvinha', 'https://img-global.cpcdn.com/recipes/10ae458cb6fea4e9/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25358138', 'Khanh Tran')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', '500 gr thịt ba chỉ', 'r thịt ba chỉ', '500 g', 1),
('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', 'Gia vị: ngũ vị hương, muối, bột ngọt, đường', 'gia vị', 'ngũ vị hương, muối, bột ngọt, đường', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', 1, 'Rửa sạch ba chỉ, để ráo. Cắt dây ba chỉ thành 3 khúc dài bằng nhau.', ''),
('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', 2, 'Ướp thịt ba chỉ với 1 mcf bột ngũ vị hương, 1 mcf muối hột, 1/2 mcf bột ngọt, 1 xíu đường. Xoa đều gia vị ướp đều khắp các mặt thịt, để vào ngăn mát, ướp qua đêm.', ''),
('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', 3, 'Cho xíu dầu vô chảo, dầu nóng thì cho thịt ba chỉ đã tẩm ướp gia vị vào chiên chín vàng các mặt. Đậy nắp chảo để bớt văng mỡ. Hạ nhỏ lửa để chiên chín thịt, tránh tình trạng ngoài cháy trong sống.', 'https://img-global.cpcdn.com/steps/b403a47460a35675/400x400cq80/photo.jpg'),
('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', 4, 'Thịt chín, để nguội xíu rồi gắp ra, xắt miếng mỏng vừa ăn.', 'https://img-global.cpcdn.com/steps/a1ae6196d6bf6aea/400x400cq80/photo.jpg'),
('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', 5, 'Món này ăn với cơm, xôi nóng hoặc cuốn với rau xà lách. Miếng thịt mằn mặn bên ngoài, mềm mại ngọt thịt bên trong. Ăn miếng thịt uống miếng bia, ngon quá đi.', 'https://img-global.cpcdn.com/steps/879cd3389bdef4ff/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', 480, 30.0, 25.0, 24.0, 3.0, 30.3, 2.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', 'món ngon mỗi ngày'),
('24fbe51a-ddd0-48bd-acd7-a7b29fb481b5', 'dễ làm');

-- Món ăn: Thịt Ba Chỉ Nướng Lá Mắc Mật
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('27abee81-93a4-4622-bf5c-bb01160c7be7', 'Thịt Ba Chỉ Nướng Lá Mắc Mật', 'Thật ra món này ăn lúc nào cũng được, đãi khách, lai rai, làm mồi nhậu, nhưng cũng là 1 lựa chọn tết vì nguyên liệu trữ được, thịt và lá mắc mật mình đều trữ đông, nướng lại nhàn bằng nồi chiên không dầu. #beptetvinha', 'https://img-global.cpcdn.com/recipes/23caa19fa71f062f/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24913163', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('27abee81-93a4-4622-bf5c-bb01160c7be7', '500 gr thịt ba chỉ', 'r thịt ba chỉ', '500 g', 1),
('27abee81-93a4-4622-bf5c-bb01160c7be7', '40 lá mắc mật', 'á mắc mật', '40 l', 1),
('27abee81-93a4-4622-bf5c-bb01160c7be7', '16 cái xiên que', 'xiên que', '16 cái', 1),
('27abee81-93a4-4622-bf5c-bb01160c7be7', '1 tbsp nước cốt hành tỏi xay', 'nước cốt hành tỏi xay', '1 tbsp', 1),
('27abee81-93a4-4622-bf5c-bb01160c7be7', '1 tbsp mirin', 'mirin', '1 tbsp', 1),
('27abee81-93a4-4622-bf5c-bb01160c7be7', '1 chén mắm tôm pha (1:1:1 mắm:chanh:đường)', 'mắm tôm pha', '1 chén', 1),
('27abee81-93a4-4622-bf5c-bb01160c7be7', '1 quả ớt xắt', 'ớt xắt', '1 quả', 1),
('27abee81-93a4-4622-bf5c-bb01160c7be7', 'Gia vị thông thường', 'gia vị thông thường', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('27abee81-93a4-4622-bf5c-bb01160c7be7', 1, 'Ba chỉ cắt con chì, ướp với chục lá mắc mật vò nát, 1 tbsp nước mắm, 1 tsp đường, 1 tbsp nước cốt hành tỏi, 1 tbsp mirin ít nhất 15 phút.', 'https://img-global.cpcdn.com/steps/296cf53b499f0f53/400x400cq80/photo.jpg'),
('27abee81-93a4-4622-bf5c-bb01160c7be7', 2, 'Dùng xiên xiên xen kẽ thịt và lá. Làm nóng nckd, cho vào nướng từng mẻ 10-15 phút có trở mặt.', 'https://img-global.cpcdn.com/steps/5150f26f44e2caa6/400x400cq80/photo.jpg'),
('27abee81-93a4-4622-bf5c-bb01160c7be7', 3, 'Pha mắm tôm chấm kèm.', 'https://img-global.cpcdn.com/steps/f9412340c5a35870/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('27abee81-93a4-4622-bf5c-bb01160c7be7', 580, 30.0, 25.0, 32.0, 3.0, 22.0, 2.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('27abee81-93a4-4622-bf5c-bb01160c7be7', 'món ngon mỗi ngày'),
('27abee81-93a4-4622-bf5c-bb01160c7be7', 'dễ làm');

-- Món ăn: Ba rọi xào mắm ruốc
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', 'Ba rọi xào mắm ruốc', 'Món này ăn cùng cơm nóng là siêu dính luôn hihi 😜', 'https://img-global.cpcdn.com/recipes/5a61c6efd66bc26a/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25370807', 'Trang Nguyen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', '500 g thịt ba chỉ', 'thịt ba chi', '500 g', 1),
('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', 'Mắm ruốc', 'mắm ruốc', 'Tùy lượng', 1),
('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', '3-4 cây sả băm nhỏ', 'sả băm nho', '3-4 cây', 1),
('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', 'tỏi, đường, ớt', 'tỏi, đường, ớt', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', 1, 'Thịt rửa sạch, chần sơ, cắt nhỏ', ''),
('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', 2, 'Cho thịt lên bếp đến khi thịt hơi cháy cạnh, tươm mỡ, lấy bớt mỡ ra', ''),
('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', 3, 'Cho tỏi băm, sả băm vào chảo, cho tiếp 1, 5 mc mắm ruốc, 2mc đường, 1mc tương ớt vào đảo đều, cho tiếp 1/2 chén nước lọc, đun lửa vừa đến khi hỗn hợp sệt lại, cho ớt trái đập dập vào, nêm nếm lại theo khẩu vị.', 'https://img-global.cpcdn.com/steps/775a4ca518cf8289/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', 300, 15.0, 25.0, 10.0, 3.0, 23.6, 3.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', 'món ngon mỗi ngày'),
('4482308e-43e1-4e9a-9ea2-8ee0b47f5e2e', 'dễ làm');

-- Món ăn: Thịt Ba Rọi Kho Củ Cải Khô
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', 'Thịt Ba Rọi Kho Củ Cải Khô', 'Củ cải khô là lựa chọn hợp lý thay thế rau củ tươi khi rau xanh tăng giá. Củ cải khô loại này khi mua là từng sợi dài, vị nhạt, ngâm nở rồi chế biến tuỳ ý.', 'https://img-global.cpcdn.com/recipes/ad723284bdbbc470/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24637599', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', '200 gr thịt ba rọi, cắt con chì', 'r thịt ba rọi, cắt con chì', '200 g', 1),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', '50 gr củ cải khô', 'r củ cải khô', '50 g', 1),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', '1 ít hành lá', 'hành lá', '1 ít', 1),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', '1/4 chén nước sôi', 'nước sôi', '1/4 chén', 1),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', '1 tsp hành tím băm', 'hành tím băm', '1 tsp', 1),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', '1 tsp tỏi băm', 'tỏi băm', '1 tsp', 1),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', '1 tbsp nước mắm', 'nước mắm', '1 tbsp', 1),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', '1 tsp nước màu', 'nước màu', '1 tsp', 1),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', '1 tbsp đường thốt nốt', 'đường thốt nốt', '1 tbsp', 1),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', '1 ít tiêu xay', 'tiêu xay', '1 ít', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', 1, 'Ngâm củ cải khô với nước nhiệt độ phòng, trong khoảng 1 giờ. Rửa sạch 2-3 lần, vắt khô. Củ cải loại này không mặn. Cắt khúc 4-5 cm.', 'https://img-global.cpcdn.com/steps/0f3bfd710aff945b/400x400cq80/photo.jpg'),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', 2, 'Ướp thịt với 1/2 chỗ hành tỏi băm, nước mắm, đường, nước màu.', 'https://img-global.cpcdn.com/steps/000d383553d0da37/400x400cq80/photo.jpg'),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', 3, 'Phi thơm hành tỏi còn lại và xào săn thịt cùng củ cải. Thêm nước nấu sôi hạ lửa.', 'https://img-global.cpcdn.com/steps/90802de660cdd702/400x400cq80/photo.jpg'),
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', 4, 'Thịt mềm thấm, củ cải giòn thấm vị là được. Mình kho khoảng 30 phút. Múc ra đĩa rắc hành lá, tiêu xay.', 'https://img-global.cpcdn.com/steps/5566b75e76b69467/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', 300, 15.0, 31.0, 10.0, 6.5, 35.6, 3.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('65a7c505-d6a1-4465-b2ff-d28d9663c8dc', 'món kho');

-- Món ăn: Thịt ba rọi nấu lagu
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('aa7ce3f4-42ad-454c-845d-8553e884a261', 'Thịt ba rọi nấu lagu', '#Cookpadapron2025 Ngoài gà, sườn... thì có thể nấu thịt dạng lagu, món ăn mềm ngon và đỡ phải lấy xương ra như các nguyên liệu khác', 'https://img-global.cpcdn.com/recipes/025c15abb7663bf8/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25306486', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('aa7ce3f4-42ad-454c-845d-8553e884a261', '1 kg thịt ba rọi', 'thịt ba rọi', '1 kg', 1),
('aa7ce3f4-42ad-454c-845d-8553e884a261', '400 g khoai tây bi', 'khoai tây bi', '400 g', 1),
('aa7ce3f4-42ad-454c-845d-8553e884a261', '2 củ cà rốt', 'cà rốt', '2 củ', 1),
('aa7ce3f4-42ad-454c-845d-8553e884a261', '50 g hành lá', 'hành lá', '50 g', 1),
('aa7ce3f4-42ad-454c-845d-8553e884a261', '2 mc hành tỏi băm', 'mc hành tỏi băm', '2', 1),
('aa7ce3f4-42ad-454c-845d-8553e884a261', 'Gia vị', 'gia vị', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('aa7ce3f4-42ad-454c-845d-8553e884a261', 1, 'Thịt ruaqr sạch, cắt lát mỏng, ướp 30 phút với 1mcf hạt nêm, 1/2mcf tiêu xay, 1mc hành tỏi băm. Khoai tây cà rốt gọt vỏ, cắt vừa ăn. Phi thơm 1mc hành tỏi băm, cho thịt đã ướp vào xào săn', 'https://img-global.cpcdn.com/steps/27f7a39202d44fff/400x400cq80/photo.jpg'),
('aa7ce3f4-42ad-454c-845d-8553e884a261', 2, 'Thêm 2mc tương cà, 1mcf muối, 1mc đường vào xào cho thịt thấm gia vị, thêm nước nấu sôi rồi cho khoai tây cà rốt vào nấu mềm', 'https://img-global.cpcdn.com/steps/ec55b601727469a0/400x400cq80/photo.jpg'),
('aa7ce3f4-42ad-454c-845d-8553e884a261', 3, 'Thịt và các loại củ mềm thì nêm lại gia vị cho vừa ăn, thêm 1mc bột năng hòa với 1/3 chén nước, cho vào nồi khuấy đều cho sốt sệt lại, tắt bếp và thêm hành lá, tiêu xay', 'https://img-global.cpcdn.com/steps/29b6d94fd2be1236/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('aa7ce3f4-42ad-454c-845d-8553e884a261', 420, 15.0, 61.0, 10.0, 6.5, 30.6, 1.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('aa7ce3f4-42ad-454c-845d-8553e884a261', 'món ngon mỗi ngày'),
('aa7ce3f4-42ad-454c-845d-8553e884a261', 'dễ làm');

-- Món ăn: SP.1032 - Ba Rọi Heo Kho Thơm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', 'SP.1032 - Ba Rọi Heo Kho Thơm', 'Lâu lâu mình vẫn dùng nguyên liệu là trái dứa hoặc thơm để kho và xào trong các bữa ăn.', 'https://img-global.cpcdn.com/recipes/e09b5585ecccbb25/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25289690', 'Shan Wu')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', '300 g ba rọi heo', 'ba rọi heo', '300 g', 1),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', '150 g thơm (dứa)', 'thơm', '150 g', 1),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', '1 muỗng cafe hạt nêm', 'cafe hạt nêm', '1 muỗng', 1),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', '2 muỗng canh nước mắm', 'nước mắm', '2 muỗng canh', 1),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', '1 muỗng cafe tỏi băm', 'cafe tỏi băm', '1 muỗng', 1),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', '1 muỗng cafe đường', 'cafe đường', '1 muỗng', 1),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', '1 muỗng canh dầu ăn', 'dầu ăn', '1 muỗng canh', 1),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', '100 ml nước lọc', 'nước lọc', '100 ml', 1),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', '1 trái ớt', 'ớt', '1 trái', 1),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', '2 nhánh hành lá', 'hành lá', '2 nhánh', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', 1, 'Thịt ba rọi cắt miếng vừa ăn, ướp với hạt nêm, nước mắm, tỏi băm 15 phút.', ''),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', 2, 'Thơm cắt miếng vừa ăn, ớt và hành lá cắt nhỏ.', ''),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', 3, 'Đun nóng dầu ăn, cho đường vào thắng caramel đến màu cánh gián.', ''),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', 4, 'Cho thịt vào xào săn, tiếp tục cho thơm vào đảo đều.', ''),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', 5, 'Thêm nước lọc, nước mắm, ớt, hành lá kho lửa lớn đến khi nước sệt lại.', 'https://img-global.cpcdn.com/steps/0c304023f8e95def/400x400cq80/photo.jpg'),
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', 6, 'Tắt bếp và thưởng thức', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', 480, 30.0, 25.0, 24.0, 3.0, 44.9, 3.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('d3151a77-6ea1-4100-ad79-2b9f6b5d0c8d', 'món kho');

-- Món ăn: SP.1031 - Ba Rọi Heo Xào Dứa
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('40d6d82a-d816-4f76-b5fd-b56d27d78cab', 'SP.1031 - Ba Rọi Heo Xào Dứa', '#CookpadApron2025 - Tuần 40: thơm, dứa, khóm', 'https://img-global.cpcdn.com/recipes/647a3af0cbb77840/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/25274458', 'Shan Wu')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', '300 g ba rọi heo', 'ba rọi heo', '300 g', 1),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', '250 g thơm', 'thơm', '250 g', 1),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', '1 muỗng cà phê hạt nêm', 'hạt nêm', '1 muỗng cà phê', 1),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', '1/2 muỗng cà phê tiêu', 'tiêu', '1/2 muỗng cà phê', 1),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', '15 g hành lá', 'hành lá', '15 g', 1),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', '1 muỗng canh dầu ăn', 'dầu ăn', '1 muỗng canh', 1),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', '1 muỗng canh dầu hào', 'dầu hào', '1 muỗng canh', 1),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', '1 muỗng cf dầu mè', 'cf dầu mè', '1 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', 1, 'Thịt heo thái hình con chì, ướp với hạt nêm và tiêu trong 15 phút.', 'https://img-global.cpcdn.com/steps/a91644e2a317833a/400x400cq80/photo.jpg'),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', 2, 'Dứa gọt vỏ, xắt miếng dày 2-3cm.', 'https://img-global.cpcdn.com/steps/0551a749eed336d4/400x400cq80/photo.jpg'),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', 3, 'Làm nóng chảo, cho dầu ăn vào, xào thịt heo cho săn lại. Thêm chút nước cho thịt heo chín mềm.', 'https://img-global.cpcdn.com/steps/50622ebc7122c6ea/400x400cq80/photo.jpg'),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', 4, 'Thêm dứa vào xào chung đến khi dứa chín mềm.', 'https://img-global.cpcdn.com/steps/97b9f380b53652bc/400x400cq80/photo.jpg'),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', 5, 'Cho dầu hào và hành lá cắt khúc vào đảo đều, tắt bếp.', 'https://img-global.cpcdn.com/steps/eb59983920e84a48/400x400cq80/photo.jpg'),
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', 6, 'Trước khi múc ra dĩa, rưới vài giọt dầu mè lên trên cho thơm.', 'https://img-global.cpcdn.com/steps/fdbba1c58bf34d7d/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('40d6d82a-d816-4f76-b5fd-b56d27d78cab', 480, 30.0, 25.0, 24.0, 3.0, 33.4, 3.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('40d6d82a-d816-4f76-b5fd-b56d27d78cab', 'món xào');

-- Món ăn: Ba chỉ kho trứng
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', 'Ba chỉ kho trứng', 'Có nhiều cách kho ngon nhưng đây là cách mình kho thịt ba chỉ và trứng nhanh nhất để kịp có bữa cơm tối cho gia đình khi làm về muộn.', 'https://img-global.cpcdn.com/recipes/d0eac32e3f131f4b/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25292851', 'Khanh Tran')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', '350 gr thịt ba chỉ', 'r thịt ba chỉ', '350 g', 1),
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', '6 trứng gà cỡ nhỏ', 'trứng gà cỡ nhỏ', '6', 1),
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', '2 mc mắm', 'mc mắm', '2', 1),
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', '1 mcf nước màu dừa', 'mcf nước màu dừa', '1', 1),
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', '3/4 mc đường', 'mc đường', '3/4', 1),
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', '1/2 mcf bột ngọt', 'mcf bột ngọt', '1/2', 1),
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', '1/2 mcf muối', 'mcf muối', '1/2', 1),
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', '1 mcf hạt nêm', 'mcf hạt nêm', '1', 1),
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', '2 củ hành tím băm, tiêu', 'hành tím băm, tiêu', '2 củ', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', 1, 'Cắt thịt ba chỉ to cỡ đầu ngón tay cái. Cho vào nồi cùng tất cả nguyên liệu trên. Cho nước nóng vào cao hơn mặt thịt 1 lóng tay. Lên lửa và kho thịt trước. Cho thêm ớt trái nếu thích. Nhà mình có con nít nên không thêm ớt. Khi thịt sôi thì hạ lửa vừa nhỏ và tiếp tục kho.', 'https://img-global.cpcdn.com/steps/3b6d9a6266ea127d/400x400cq80/photo.jpg'),
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', 2, 'Cùng lúc luộc trứng. Trứng chín, bóc vỏ. Thả trứng vào nồi thịt đang kho. Trộn thịt bên dưới lên, và đẩy trứng xuống dưới nước kho để trứng thấm gia vị. Mở nắp nồi. Tiếp tục kho liu riu.', 'https://img-global.cpcdn.com/steps/db62d18682639546/400x400cq80/photo.jpg'),
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', 3, 'Kho nhỏ lửa đến khi nước cạn bớt đi. Mình nêm nếm lại gia vị xem vừa chưa. Tắt bếp. Múc tô cơm, cho 1 vá đầy thịt và trứng vào. Thêm 2-3 vá nước thịt kho, dằm trái ớt. Trộn tất cả lên. Ăn kèm rau luộc. Nhanh gọn mà ngon.', 'https://img-global.cpcdn.com/steps/d0dd9141a7e8a3d8/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', 480, 30.0, 25.0, 24.0, 3.0, 59.9, 3.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('cddc00c3-2b2e-4cb7-ab6a-933539a4912a', 'món kho');

-- Món ăn: Thịt ba rọi kho mắm ruốc
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('81780e6d-5b39-4b04-b703-37ff239be8b1', 'Thịt ba rọi kho mắm ruốc', '#10Nam1HanhTrinh Món ăn này với hương vị rất đặc biệt từ mắm ruốc là một sự lựa chọn tuyệt vời cho những bữa cơm nhà. Mắm ruốc Huế có lẽ là hợp hơn cả cho món ăn này bởi vị mặn vừa phải, giúp món ăn ngon hơn; đồng thời lần này mình cũng ướp đường trước giúp miếng mỡ trong đẹp mắt hơn. Đây cũng là món ăn khép lại hành trình mừng Cookpad tròn 10 tuổi, vậy nên mình cũng lựa chọn những món quà nhỏ xinh từ Cookpad kèm theo món ăn để gợi nhớ chặng đường đồng hành cùng Cookpad ❤️', 'https://img-global.cpcdn.com/recipes/9f3d4817b7377df2/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25255725', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('81780e6d-5b39-4b04-b703-37ff239be8b1', '500 g thịt ba rọi', 'thịt ba rọi', '500 g', 1),
('81780e6d-5b39-4b04-b703-37ff239be8b1', '1 mc sả băm', 'mc sả băm', '1', 1),
('81780e6d-5b39-4b04-b703-37ff239be8b1', '2 mc mắm ruốc Huế', 'mc mắm ruốc huế', '2', 1),
('81780e6d-5b39-4b04-b703-37ff239be8b1', '2 mc đường', 'mc đường', '2', 1),
('81780e6d-5b39-4b04-b703-37ff239be8b1', '1/2 mcf tiêu xay', 'mcf tiêu xay', '1/2', 1),
('81780e6d-5b39-4b04-b703-37ff239be8b1', '1 mc dầu ăn', 'mc dầu ăn', '1', 1),
('81780e6d-5b39-4b04-b703-37ff239be8b1', 'Rau củ dùng kèm (cà rốt, bắp non, đậu bắp, dưa leo)', 'rau củ dùng kèm', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('81780e6d-5b39-4b04-b703-37ff239be8b1', 1, 'Thịt cắt miếng vừa ăn, bóp muối rửa sạch và xả lại nhiều lần, ướp với 1mc đường trong 1 tiếng. Phi thơm sả băm, cho thịt vào đảo săn cho thịt xém vàng thì cho mắm ruốc vào đảo tiếp', 'https://img-global.cpcdn.com/steps/5196da02e26eb684/400x400cq80/photo.jpg'),
('81780e6d-5b39-4b04-b703-37ff239be8b1', 2, 'Thêm đường vào và đảo đều cho đường tan và thịt thấm gia vị', 'https://img-global.cpcdn.com/steps/9f4932d8e38c4972/400x400cq80/photo.jpg'),
('81780e6d-5b39-4b04-b703-37ff239be8b1', 3, 'Rau củ sơ chế sạch. Đặt nồi nước lên bếp, thêm chút muối, nước sôi cho cà rốt và bắp non vào', 'https://img-global.cpcdn.com/steps/7264223978e27bc9/400x400cq80/photo.jpg'),
('81780e6d-5b39-4b04-b703-37ff239be8b1', 4, 'Khi bắp non và cà rốt gần mềm thì cho đậu bắp vào luộc nhanh, vớt ra để ráo', 'https://img-global.cpcdn.com/steps/4dd24cc751cce948/400x400cq80/photo.jpg'),
('81780e6d-5b39-4b04-b703-37ff239be8b1', 5, 'Múc thịt ra dĩa, thêm ít tiêu xay kèm dĩa rau củ nhiều màu sắc thật hấp dẫn', 'https://img-global.cpcdn.com/steps/f1a58526982b7b95/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('81780e6d-5b39-4b04-b703-37ff239be8b1', 300, 15.0, 31.0, 10.0, 6.5, 43.1, 3.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('81780e6d-5b39-4b04-b703-37ff239be8b1', 'món kho');

-- Món ăn: Ba chỉ rang cháy cạnh
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('e5e379d7-a040-4c88-9812-de524fd50aa7', 'Ba chỉ rang cháy cạnh', 'Món này chắc gọi là món quốc dân quá, vì mức độ phổ biến với mọi nhà.', 'https://img-global.cpcdn.com/recipes/ba21cdbfc4614ead/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25261491', 'Khanh Tran')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('e5e379d7-a040-4c88-9812-de524fd50aa7', '300 gr thịt ba chỉ', 'r thịt ba chỉ', '300 g', 1),
('e5e379d7-a040-4c88-9812-de524fd50aa7', '1.5 mc mắm', 'mc mắm', '1.5', 1),
('e5e379d7-a040-4c88-9812-de524fd50aa7', '1 mc đường', 'mc đường', '1', 1),
('e5e379d7-a040-4c88-9812-de524fd50aa7', '1 nhánh hành lá', 'hành lá', '1 nhánh', 1),
('e5e379d7-a040-4c88-9812-de524fd50aa7', 'xíu tiêu', 'xíu tiêu', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('e5e379d7-a040-4c88-9812-de524fd50aa7', 1, 'Cắt thịt ba chỉ bằng cỡ đầu ngón tay cái và đều nhau.', 'https://img-global.cpcdn.com/steps/3c5a93176abeb0f6/400x400cq80/photo.jpg'),
('e5e379d7-a040-4c88-9812-de524fd50aa7', 2, 'Làm nóng chảo, cho xíu xiu dầu vô cho trơn chảo. Cho thịt ba chỉ vào, rang cho vàng các mặt, nước mỡ tiết ra.', 'https://img-global.cpcdn.com/steps/7f194e3d961a0384/400x400cq80/photo.jpg'),
('e5e379d7-a040-4c88-9812-de524fd50aa7', 3, 'Lọc nước mỡ ra chén riêng, làm mỡ nước sau xào rau, kho cá thay dầu ăn.', 'https://img-global.cpcdn.com/steps/53e530de821cebf2/400x400cq80/photo.jpg'),
('e5e379d7-a040-4c88-9812-de524fd50aa7', 4, 'Cho mắm và đường vô xóc trộn đều với thịt trong chảo. Khi thịt thấm đều gia vị thì cho tiêu và hành lá cắt khúc vào. Đảo đều. Tắt bếp và dọn ăn thôi.', 'https://img-global.cpcdn.com/steps/53ae3d3054fa9286/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('e5e379d7-a040-4c88-9812-de524fd50aa7', 480, 30.0, 25.0, 24.0, 3.0, 47.4, 3.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('e5e379d7-a040-4c88-9812-de524fd50aa7', 'món ngon mỗi ngày'),
('e5e379d7-a040-4c88-9812-de524fd50aa7', 'dễ làm');

-- Món ăn: Cá Kèo Kho Tiêu Với Thịt Ba Rọi
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('5910edea-6498-4f41-aae0-f1a4bb3312e7', 'Cá Kèo Kho Tiêu Với Thịt Ba Rọi', '#10Nam1HanhTrinh #Thang12 #CaiTienMonAn Xưa nay, mỗi khi kho cá với thịt, chúng ta thường ướp gia vị từ đầu rồi bắc lên bếp kho. Điều này khiến cho đôi lúc, độ chín mềm và độ thấm gia vị của món ăn không đồng nhất (vì độ dai, độ chín của thịt khác cá). Và vì ướp theo từng món nên cũng chính một món kho với các nguyên liệu như nhau, thì hương vị của mỗi lần nấu sẽ có sự khác biệt đôi chút. Sau khi tìm hiểu và học hỏi ở một số bạn bè, mình đã thử pha nước xốt kho trước rồi mới tiến hành kho. Cũng như thời gian cho các nguyên liệu vào nấu cũng sẽ khác nhau để đảm bảo độ chín mềm tương đương với nhau. Đặc biệt là hương vị của món kho ở các lần nấu khác nhau vẫn giữ hương vị gần như giống nhau… #CaKeoKhoTieuVoiThitBaRoi #HuynhPhatKitchen', 'https://img-global.cpcdn.com/recipes/1c66c0a153db7655/1200x630cq80/photo.jpg', 30, 'Trung bình', '5-6 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25245174', 'Huỳnh Phát')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '300 gam cá Kèo, làm rửa sạch, cắt đôi', 'am cá kèo, làm rửa sạch, cắt đôi', '300 g', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '300 gam thịt ba rọi (hoặc thịt nọng)', 'am thịt ba rọi', '300 g', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '1 tbsp hành tím xay', 'hành tím xay', '1 tbsp', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '1 tbsp tỏi xay', 'tỏi xay', '1 tbsp', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '6 tbsp đường vàng', 'đường vàng', '6 tbsp', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '120 gam nước mắm', 'am nước mắm', '120 g', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '120 gam nước lọc', 'am nước lọc', '120 g', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '1/2 tbsp bột ngọt', 'bột ngọt', '1/2 tbsp', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '1/2 tbsp hạt nêm', 'hạt nêm', '1/2 tbsp', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '1 tbsp tương ớt', 'tương ớt', '1 tbsp', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '1/2 tbsp sa tế', 'sa tế', '1/2 tbsp', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '1 tbsp dầu màu điều', 'dầu màu điều', '1 tbsp', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '1.5 tbsp nước màu dừa', 'nước màu dừa', '1.5 tbsp', 1),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', '1 tbsp tiêu', 'tiêu', '1 tbsp', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('5910edea-6498-4f41-aae0-f1a4bb3312e7', 1, 'Pha nước xốt kho cá: 120g nước mắm + 90g đường + 1/2tbsp bột ngọt + 1/2tbsp hạt nêm + 1tbsp tương ớt + 1/2tbsp sa tế + 1tbsp dầu màu điều + 1.5tbsp nước màu dừa + 1/2tbps tiêu + 120g nước lọc. Khuấy cho tất cả hoà tan với nhau. (Nếu muốn để dành, ta có thể pha nhiều, phi hành tỏi cho thơm rồi cho nước xốt vô nấu sôi 5 phút, để nguội rồi cho vô hũ, để vô tủ lạnh. Khi nào dùng thì múc ra)', 'https://img-global.cpcdn.com/steps/4a75bbe554faac74/400x400cq80/photo.jpg'),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', 2, 'Thịt ba rọi trụng sơ qua nước sôi khoảng 2 phút rồi vớt ra rửa lại thật sạch. Sau đó, ta xắt miếng vừa ăn rồi cho lại vô nồi cùng một chút xíu nước lạnh (để tránh cho thịt dính đáy nồi) và bắc lên bếp. Nước sẽ bốc hơi dần hết và phần mỡ trong thịt sẽ bắt đầu tươm ra (ở bước này, nếu mỡ tươm ra nhiều quá, ta có thể dùng muỗng múc ra bớt). Ta cứ chấy thịt như vậy cho đến khi thịt hơi xém vàng thì cho vô 1tbsp hành tím băm + 1tbsp tỏi băm để phi lên cho thơm.', 'https://img-global.cpcdn.com/steps/39859735ac86e6d7/400x400cq80/photo.jpg'),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', 3, 'Hành tỏi vừa thơm thì ta cho toàn bộ phần nước xốt đã chuẩn bị trước đó vô nồi thịt, vặn lửa lớn để nước xốt sôi bùng lên và thấm thịt. Khi ta thấy miếng thịt đã vàng vì thấm gia vị và bắt đầu chín mềm thì ta cho phần cá Kèo đã làm sạch, cắt đôi vô kho chung.', 'https://img-global.cpcdn.com/steps/74b04adfd234a717/400x400cq80/photo.jpg'),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', 4, 'Đảo nhẹ cho cá Kèo trộn lẫn thịt ba rọi. Khi nước xốt kho đã sôi lên thì ta hạ lửa nhỏ vừa cho nước xốt sôi liu riu để cho cá Kèo thấm dần gia vị… Ta cứ kho như thế cho đến lúc nước xốt sánh lại còn 1/2 hoặc 1/3 và cá đã chín mềm là được. Nêm nếm lại lần cuối cho vừa với khẩu vị gia đình rồi tắt bếp.', 'https://img-global.cpcdn.com/steps/da1a8d3875c8ea0a/400x400cq80/photo.jpg'),
('5910edea-6498-4f41-aae0-f1a4bb3312e7', 5, 'Múc món ăn ra dĩa, rắc thêm tiêu và thưởng thức với cơm nóng.', 'https://img-global.cpcdn.com/steps/8a4132c2520b308e/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('5910edea-6498-4f41-aae0-f1a4bb3312e7', 380, 31.0, 25.0, 14.0, 3.0, 36.1, 4.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('5910edea-6498-4f41-aae0-f1a4bb3312e7', 'món kho');

-- Món ăn: Thịt ba chỉ nướng NCKD
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('69f69b95-4464-43b9-88b0-8927549e232a', 'Thịt ba chỉ nướng NCKD', 'Thịt nướng là món ăn hoài không ngán.', 'https://img-global.cpcdn.com/recipes/237d9303fec30e28/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25257903', 'Khanh Tran')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('69f69b95-4464-43b9-88b0-8927549e232a', '500 gr ba chỉ', 'r ba chỉ', '500 g', 1),
('69f69b95-4464-43b9-88b0-8927549e232a', '1 mc xì dầu', 'mc xì dầu', '1', 1),
('69f69b95-4464-43b9-88b0-8927549e232a', '1 mc đường/mật ong', 'mc đường/mật ong', '1', 1),
('69f69b95-4464-43b9-88b0-8927549e232a', '1 mc sữa đặc', 'mc sữa đặc', '1', 1),
('69f69b95-4464-43b9-88b0-8927549e232a', '1 mc dầu hào', 'mc dầu hào', '1', 1),
('69f69b95-4464-43b9-88b0-8927549e232a', '1 mc nước màu', 'mc nước màu', '1', 1),
('69f69b95-4464-43b9-88b0-8927549e232a', '1 mcf bột nêm', 'mcf bột nêm', '1', 1),
('69f69b95-4464-43b9-88b0-8927549e232a', '1 mcf ngũ vị hương', 'mcf ngũ vị hương', '1', 1),
('69f69b95-4464-43b9-88b0-8927549e232a', '1/2 mcf dầu điều/ bột điều', 'mcf dầu điều/ bột điều', '1/2', 1),
('69f69b95-4464-43b9-88b0-8927549e232a', 'bột hành, bột tỏi', 'bột hành, bột tỏi', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('69f69b95-4464-43b9-88b0-8927549e232a', 1, 'Trộn nước ướp. Ướp ba chỉ và để tủ lạnh trong ít nhất 3 tiếng.', 'https://img-global.cpcdn.com/steps/373ad6aa2b06ad41/400x400cq80/photo.jpg'),
('69f69b95-4464-43b9-88b0-8927549e232a', 2, 'Cho thịt vào NCKD. Nướng lần 1 (180 độ, 13 phút). Lật mặt, nướng lần 2 (190 độ, 7 phút). Mình ngại rửa nồi, nên cho vào khay nướng bánh. Nếu để ra khay đúng của nồi thì thịt sẽ khô ráo hơn.', 'https://img-global.cpcdn.com/steps/03dbb89c2ef7db63/400x400cq80/photo.jpg'),
('69f69b95-4464-43b9-88b0-8927549e232a', 3, 'Lấy thịt ra, và xắt mỏng. Ăn kèm cơm hoặc xôi nóng. Thêm miếng rau hoặc đồ chua, quá hợp.', 'https://img-global.cpcdn.com/steps/62af2e9c3bdfb565/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('69f69b95-4464-43b9-88b0-8927549e232a', 580, 30.0, 25.0, 32.0, 3.0, 28.8, 1.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('69f69b95-4464-43b9-88b0-8927549e232a', 'món ngon mỗi ngày'),
('69f69b95-4464-43b9-88b0-8927549e232a', 'dễ làm');

-- Món ăn: Ba Chỉ Chiên Giòn Sốt Thái
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('3ae9095d-044c-42f5-833f-50e39152562b', 'Ba Chỉ Chiên Giòn Sốt Thái', 'Món lai rai giòn giòn với sốt chấm chua cay mặn ngọt giúp không ngán. Đặc biệt món này làm tốn thời gian sấy để chiên giòn hơn. #cookpadapron2025', 'https://img-global.cpcdn.com/recipes/090b2595d8ccf699/1200x630cq80/photo.jpg', 30, 'Trung bình', '5 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24960458', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('3ae9095d-044c-42f5-833f-50e39152562b', '1 kg Ba chỉ heo (bỏ da)', 'ba chỉ heo', '1 kg', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '2 cây Hành lá', 'hành lá', '2 cây', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '20 g Gừng', 'gừng', '20 g', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '1 thìa canh Muối', 'muối', '1 thìa canh', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '2 thìa canh Giấm', 'giấm', '2 thìa canh', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '2 quả Ớt xanh', 'ớt xanh', '2 quả', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '2 quả Ớt đỏ', 'ớt đỏ', '2 quả', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '2 thìa canh Đường thốt nốt', 'đường thốt nốt', '2 thìa canh', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '2 quả Tắc/ 1/2 quả chanh', 'tắc/ 1/2 quả chanh', '2 quả', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '2 nhánh Rễ ngò', 'rễ ngò', '2 nhánh', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '3 tép Tỏi', 'tỏi', '3 tép', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '1 lá chanh Thái (lá chúc)', 'á chanh thái', '1 l', 1),
('3ae9095d-044c-42f5-833f-50e39152562b', '1/2 thìa cà phê thính gạo', 'thính gạo', '1/2 thìa cà phê', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('3ae9095d-044c-42f5-833f-50e39152562b', 1, 'Ba chỉ bỏ da, rửa sạch, luộc với hành, gừng, muối, giấm trong 15 phút.', 'https://img-global.cpcdn.com/steps/d7021b4693fd9322/400x400cq80/photo.jpg'),
('3ae9095d-044c-42f5-833f-50e39152562b', 2, 'Vớt ra, để nguội, xắt miếng dày 1cm.', 'https://img-global.cpcdn.com/steps/0cd89f88c9eb8c7c/400x400cq80/photo.jpg'),
('3ae9095d-044c-42f5-833f-50e39152562b', 3, 'Sấy lò ở 100°C trong 1 giờ cho thịt khô mặt.', 'https://img-global.cpcdn.com/steps/6c9d5c45f6035ca7/400x400cq80/photo.jpg'),
('3ae9095d-044c-42f5-833f-50e39152562b', 4, 'Thịt sấy xong nghỉ 1 giờ. Lúc này có thể cấp đông ăn dần hoặc để ngăn mát ăn trong tuần.', 'https://img-global.cpcdn.com/steps/b1d5da9b266fec92/400x400cq80/photo.jpg'),
('3ae9095d-044c-42f5-833f-50e39152562b', 5, 'Chiên ngập dầu đến khi vàng giòn.', 'https://img-global.cpcdn.com/steps/cd19244c7aee48fd/400x400cq80/photo.jpg'),
('3ae9095d-044c-42f5-833f-50e39152562b', 6, 'Làm nước sốt: giã nhuyễn ớt xanh, ớt đỏ, đường thốt nốt, tắc, rễ ngò, tỏi, lá chanh xắt sợi. Đặc biệt nếu có thính gạo rang vàng thì càng thơm hơn.', 'https://img-global.cpcdn.com/steps/7e15d6e1de5c4ca1/400x400cq80/photo.jpg'),
('3ae9095d-044c-42f5-833f-50e39152562b', 7, 'Chấm ba chỉ chiên giòn với nước sốt.', 'https://img-global.cpcdn.com/steps/7e5c65391c4ba3c4/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('3ae9095d-044c-42f5-833f-50e39152562b', 580, 30.0, 25.0, 32.0, 3.0, 73.7, 1.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('3ae9095d-044c-42f5-833f-50e39152562b', 'chiên giòn');

-- Món ăn: SP.1018 - Ba Rọi Muối Hấp Lá Sen
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('a3696d0b-9d82-49d9-a69d-e7910b4c871a', 'SP.1018 - Ba Rọi Muối Hấp Lá Sen', 'Lâu lâu mình thường hấp thịt ba rọi với muối hồng để ăn. Làm như vậy ăn đỡ ngán hơn khi kho, chiên hoặc nướng', 'https://img-global.cpcdn.com/recipes/943f5a7537c21c8c/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 phần', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25244894', 'Shan Wu')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', '300 g Thịt ba rọi', 'thịt ba rọi', '300 g', 1),
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', '3 g Muối hồng', 'muối hồng', '3 g', 1),
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', '5 ml Dầu mè', 'dầu mè', '5 ml', 1),
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', '10 g Tỏi băm', 'tỏi băm', '10 g', 1),
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', '5 ml Màu gạch tôm', 'màu gạch tôm', '5 ml', 1),
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', '1 lá lớn Lá sen khô', 'á lớn lá sen khô', '1 l', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', 1, 'Ướp ba rọi với muối hồng, dầu mè, tỏi băm và màu gạch tôm trong 20 phút.', 'https://img-global.cpcdn.com/steps/561aaeb213bf47c1/400x400cq80/photo.jpg'),
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', 2, 'Đặt thịt lên lá sen, gói kín lại.', 'https://img-global.cpcdn.com/steps/2a29d82d5769acb0/400x400cq80/photo.jpg'),
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', 3, 'Hấp cách thuỷ 45 phút tính từ khi nước sôi.', 'https://img-global.cpcdn.com/steps/75105c1a0c992a56/400x400cq80/photo.jpg'),
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', 4, 'Lấy thịt ra, cắt lát, bày ra đĩa, rưới nước hấp lên trên.', 'https://img-global.cpcdn.com/steps/b9e6cd71f8cb7b6d/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('a3696d0b-9d82-49d9-a69d-e7910b4c871a', 320, 31.0, 25.0, 10.0, 3.0, 24.2, 1.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', 'món ngon mỗi ngày'),
('a3696d0b-9d82-49d9-a69d-e7910b4c871a', 'dễ làm');

-- Món ăn: Ba rọi rang lá chanh
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('fb927cda-69fe-4929-a8c8-72caa53b8745', 'Ba rọi rang lá chanh', 'để đổi khẩu vị gia đình mn cùng mình làm món này nha , ăn với canh khoai mỡ nữa thì bao hao cơm lắm luôn', 'https://img-global.cpcdn.com/recipes/3fb3e8ddbb085fb9/1200x630cq80/photo.jpg', 30, 'Trung bình', '4người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25230504', 'Thiện Chí')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('fb927cda-69fe-4929-a8c8-72caa53b8745', '1 kg thịt ba rọi', 'thịt ba rọi', '1 kg', 1),
('fb927cda-69fe-4929-a8c8-72caa53b8745', '30 gr lá chanh cắt sợi nhuyễn', 'r lá chanh cắt sợi nhuyễn', '30 g', 1),
('fb927cda-69fe-4929-a8c8-72caa53b8745', '2 trái ớt sừng cắt lát, 2 trái ớt hiểm cắt lát', 'ớt sừng cắt lát, 2 trái ớt hiểm cắt lát', '2 trái', 1),
('fb927cda-69fe-4929-a8c8-72caa53b8745', '5 củ hành tím cắt lát', 'hành tím cắt lát', '5 củ', 1),
('fb927cda-69fe-4929-a8c8-72caa53b8745', '1 củ tỏi lột vỏ cắt lát', 'tỏi lột vỏ cắt lát', '1 củ', 1),
('fb927cda-69fe-4929-a8c8-72caa53b8745', 'các loại gia vị thông thường', 'các loại gia vị thông thường', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('fb927cda-69fe-4929-a8c8-72caa53b8745', 1, 'Ba rọi sơ chế rửa sạch, cắt miếng nhỏ vừa', 'https://img-global.cpcdn.com/steps/2d6c5f089a1f221e/400x400cq80/photo.jpg'),
('fb927cda-69fe-4929-a8c8-72caa53b8745', 2, 'Pha nước xốt (1mc tương ớt, 2mc nước mắm, 1 mc đường, 1/2 mc bột ngọt, 1mcf tiêu).', 'https://img-global.cpcdn.com/steps/2df3d5a396e0c3ba/400x400cq80/photo.jpg'),
('fb927cda-69fe-4929-a8c8-72caa53b8745', 3, 'Dùng chảo chống dính đốt cho nóng chảo sau đó cho thịt vào xào đến khi ra mỡ và cháy xém thì cho hành tím, ớt, và tỏi vào', 'https://img-global.cpcdn.com/steps/aed00faf62207304/400x400cq80/photo.jpg'),
('fb927cda-69fe-4929-a8c8-72caa53b8745', 4, 'Khi hành tỏi thơm vàng thì cho xốt vào đảo nhanh tay cho xốt ngấm điều rùi cho lá chanh vào cuối cùng đảo sơ thêm lần nữa là đc', 'https://img-global.cpcdn.com/steps/5c73eeff517feee0/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('fb927cda-69fe-4929-a8c8-72caa53b8745', 380, 31.0, 25.0, 14.0, 3.0, 58.6, 3.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('fb927cda-69fe-4929-a8c8-72caa53b8745', 'món ngon mỗi ngày'),
('fb927cda-69fe-4929-a8c8-72caa53b8745', 'dễ làm');

-- Món ăn: Ba Chỉ Chao Riềng Lá Mắc Mật
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', 'Ba Chỉ Chao Riềng Lá Mắc Mật', 'Nếu có cuộc bầu chọn Món nhậu quốc dân thì mình xin bầu cho món này, mùi riềng mắm tôm nó kích thích vị giác lắm, mà lại giòn rụm nữa. Món này tốn bia lắm ạ. Lá mắc mật thì mình mua loại khô hoặc đông lạnh cũng được, vì cũng chiên giòn lên ấy ạ. #cookpadapron2025 món lai rai', 'https://img-global.cpcdn.com/recipes/5e265729d846387c/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24934635', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '400 g Thịt ba chỉ (tuỳ ý lọc bỏ bì)', 'thịt ba chỉ', '400 g', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '1 thìa canh Bột năng hoặc bột bắp', 'bột năng hoặc bột bắp', '1 thìa canh', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '2 thìa canh Nước', 'nước', '2 thìa canh', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '20 g Riềng', 'riềng', '20 g', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '2 cây Sả', 'sả', '2 cây', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '10 cái Lá mắc mật', 'lá mắc mật', '10 cái', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '10 g Nghệ tươi', 'nghệ tươi', '10 g', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '1 thìa canh Mẻ', 'mẻ', '1 thìa canh', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '1/2 thìa cà phê Mắm tôm (ướp thịt, tuỳ ý)', 'mắm tôm', '1/2 thìa cà phê', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '1/2 thìa cà phê Muối', 'muối', '1/2 thìa cà phê', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '1 thìa cà phê Đường', 'đường', '1 thìa cà phê', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '1/2 chén Dầu ăn', 'dầu ăn', '1/2 chén', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '1 muỗng mắm tôm', 'mắm tôm', '1 muỗng', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '1 muỗng cốt tắc/chanh', 'cốt tắc/chanh', '1 muỗng', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '1 muỗng đường', 'đường', '1 muỗng', 1),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', '1 quả ớt băm nhỏ', 'ớt băm nhỏ', '1 quả', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', 1, 'Giã nhuyễn riềng, sả, nghệ, lá mắc mật.', 'https://img-global.cpcdn.com/steps/f3d05b34bce040f8/400x400cq80/photo.jpg'),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', 2, 'Thịt ba chỉ lọc bỏ bì, (vì chiên lên bì hơi dai cứng, bạn để bì cũng được) rồi thái miếng vừa ăn, trộn với bột và nước, để 10 phút.', 'https://img-global.cpcdn.com/steps/794140b69efbb213/400x400cq80/photo.jpg'),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', 3, 'Trộn hỗn hợp gia vị, lá mắc mật giã nhỏ, mẻ, mắm tôm, muối, đường vào thịt, ướp 30 phút.', ''),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', 4, 'Đun nóng nhiều dầu, cho thịt vào chiên ngập dầu đến khi vàng giòn, vớt ra để ráo. Chiên cùng ít lá mắc mật để thơm và trang trí cho hấp dẫn.', 'https://img-global.cpcdn.com/steps/86eff9b49eb16248/400x400cq80/photo.jpg'),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', 5, 'Dùng nóng với cơm trắng hoặc bún. Chấm mắm tôm pha đường, tắc, ớt băm.', 'https://img-global.cpcdn.com/steps/ad0afdb8e128148b/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', 480, 30.0, 25.0, 24.0, 3.0, 34.1, 2.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', 'món ngon mỗi ngày'),
('eb43336f-e5e1-4fcc-98cd-c486d233ce4c', 'dễ làm');

-- Món ăn: Ba chỉ kho đậu hũ
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('9a1d49e8-eee3-44a9-ba5a-416971813cb9', 'Ba chỉ kho đậu hũ', 'Món ăn yêu thích của nhà mình. Miếng đậu thấm gia vị, miếng thịt mềm mọng, chan nước kho lên cơm, xăm thêm miếng ớt xiêm là hao cơm dzô cùng! #Cookpadapron2025 #dontulanh thịt heo', 'https://img-global.cpcdn.com/recipes/30d95e835f6d1021/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25201021', 'Khanh Tran')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('9a1d49e8-eee3-44a9-ba5a-416971813cb9', '3 thanh đậu hũ', 'thanh đậu hũ', '3', 1),
('9a1d49e8-eee3-44a9-ba5a-416971813cb9', '250 gr ba chỉ heo', 'r ba chỉ heo', '250 g', 1),
('9a1d49e8-eee3-44a9-ba5a-416971813cb9', 'hành tím băm, mắm, muối, tiêu, bột ngọt', 'hành tím băm, mắm, muối, tiêu, bột ngọt', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('9a1d49e8-eee3-44a9-ba5a-416971813cb9', 1, 'Chiên đậu hũ trong NCKD để se các mặt.', ''),
('9a1d49e8-eee3-44a9-ba5a-416971813cb9', 2, 'Ba chỉ heo cắt cục, ướp với 1mc mắm, 1/3 mcf muối, 1/2 mcf bột ngọt, 1/2 mcf đường, xíu tiêu, hành tím băm, 2mc nước lọc.', 'https://img-global.cpcdn.com/steps/47ccaf7f04a79c5f/400x400cq80/photo.jpg'),
('9a1d49e8-eee3-44a9-ba5a-416971813cb9', 3, 'Xếp đậu hũ chiên vào nồi/chảo, kho lửa lớn cho sôi, hạ lửa nhỏ kho liu rìu cho thịt và đậu thấm gia vị và mềm ra. Nước cạn vừa đủ, nêm lại vừa ăn rồi tắt bếp.', 'https://img-global.cpcdn.com/steps/f7e98e9c7ee017ba/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('9a1d49e8-eee3-44a9-ba5a-416971813cb9', 480, 30.0, 25.0, 24.0, 3.0, 28.2, 4.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('9a1d49e8-eee3-44a9-ba5a-416971813cb9', 'món kho');

-- Món ăn: Thịt Ba Rọi Xào Mắm Ruốc
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', 'Thịt Ba Rọi Xào Mắm Ruốc', 'Món này cứ ngày mưa, se lạnh là lại thèm. Thịt kho mắm mặn mòi. Mình học được bí quyết là thêm ít me chua sẽ làm mắm đỡ gắt. Bạn thử xem sao.', 'https://img-global.cpcdn.com/recipes/dcf4aea988c08716/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 phần ăn', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/25177373', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', '200 g Thịt ba rọi', 'thịt ba rọi', '200 g', 1),
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', '1 muỗng canh Mắm ruốc', 'mắm ruốc', '1 muỗng canh', 1),
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', '1 muỗng cà phê cốt Me chua', 'cốt me chua', '1 muỗng cà phê', 1),
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', '1 cây Sả băm', 'sả băm', '1 cây', 1),
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', '1 trái Ớt', 'ớt', '1 trái', 1),
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', '1 muỗng canh đường', 'đường', '1 muỗng canh', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', 1, 'Thịt ba rọi thái nhỏ, cho vào chảo đảo cho ra bớt mỡ.', 'https://img-global.cpcdn.com/steps/ad23b1c3a78543b8/400x400cq80/photo.jpg'),
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', 2, 'Thêm sả băm và ớt vào xào thơm. chắt bớt mỡ đi.', 'https://img-global.cpcdn.com/steps/4c90976675e5401d/400x400cq80/photo.jpg'),
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', 3, 'Pha mắm ruốc với me chua và chút nước, đường cho vào chảo đảo đều.', ''),
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', 4, 'Xào đến khi thịt săn lại, mắm ruốc thấm đều thì tắt bếp.', 'https://img-global.cpcdn.com/steps/5d2a9d0d02461e4e/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', 300, 15.0, 25.0, 10.0, 3.0, 25.9, 3.6)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('44a186c4-2e36-4feb-9a51-4e9d3fb0ce88', 'món xào');

-- Món ăn: Thịt Ba Chỉ Xào Mắm Tép
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('55f64394-349e-43b2-afa6-06321dace0d6', 'Thịt Ba Chỉ Xào Mắm Tép', 'Trời mưa gió hay se lạnh thèm những món kho hao cơm. Nếu không đi chợ được, bạn làm món này để tủ lạnh ăn dần cả tuần cũng vẫn ngon.', 'https://img-global.cpcdn.com/recipes/d5271ee6fb7399e9/1200x630cq80/photo.jpg', 30, 'Trung bình', '5 phần', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/25160935', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('55f64394-349e-43b2-afa6-06321dace0d6', '400 g Thịt ba chỉ', 'thịt ba chỉ', '400 g', 1),
('55f64394-349e-43b2-afa6-06321dace0d6', '2 muỗng cà phê Mắm tép', 'mắm tép', '2 muỗng cà phê', 1),
('55f64394-349e-43b2-afa6-06321dace0d6', '1 muỗng cà phê Đường', 'đường', '1 muỗng cà phê', 1),
('55f64394-349e-43b2-afa6-06321dace0d6', '1 muỗng cà phê Sả xay nhuyễn', 'sả xay nhuyễn', '1 muỗng cà phê', 1),
('55f64394-349e-43b2-afa6-06321dace0d6', '1 muỗng cà phê Dầu điều', 'dầu điều', '1 muỗng cà phê', 1),
('55f64394-349e-43b2-afa6-06321dace0d6', '1 muỗng cà phê Ớt băm', 'ớt băm', '1 muỗng cà phê', 1),
('55f64394-349e-43b2-afa6-06321dace0d6', '2 quả Dưa leo', 'dưa leo', '2 quả', 1),
('55f64394-349e-43b2-afa6-06321dace0d6', '1 trái Ớt tươi', 'ớt tươi', '1 trái', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('55f64394-349e-43b2-afa6-06321dace0d6', 1, 'Thịt ba chỉ rửa sạch bằng dấm muối, thấm khô, cắt con chì nhỏ.', 'https://img-global.cpcdn.com/steps/10ebddca75e8c859/400x400cq80/photo.jpg'),
('55f64394-349e-43b2-afa6-06321dace0d6', 2, 'Cho thịt vào chảo, xào lửa vừa cho ra bớt mỡ và thịt giòn lên.', 'https://img-global.cpcdn.com/steps/9a864e906b0dd7f0/400x400cq80/photo.jpg'),
('55f64394-349e-43b2-afa6-06321dace0d6', 3, 'Thêm mắm tép, đường, sả xay, dầu điều, ớt băm vào đảo đều cho thấm vị. Gia giảm độ mặn như ý, càng mặn càng để được lâu.', 'https://img-global.cpcdn.com/steps/a092d933bad36ef7/400x400cq80/photo.jpg'),
('55f64394-349e-43b2-afa6-06321dace0d6', 4, 'Xào thêm 2-3 phút cho thịt săn lại, dậy mùi thơm.', 'https://img-global.cpcdn.com/steps/e86a95e15734dcce/400x400cq80/photo.jpg'),
('55f64394-349e-43b2-afa6-06321dace0d6', 5, 'Dưa leo cắt lát, xếp quanh đĩa, cho thịt lên giữa, trang trí ớt tươi.', 'https://img-global.cpcdn.com/steps/8750452448e8f433/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('55f64394-349e-43b2-afa6-06321dace0d6', 480, 30.0, 25.0, 24.0, 3.0, 72.9, 3.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('55f64394-349e-43b2-afa6-06321dace0d6', 'món xào');

-- Món ăn: Ếch kho hành tây rau răm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', 'Ếch kho hành tây rau răm', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/d3b74cc43cbbcba9/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/25440471', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', '2 con Thịt ếch lớn', 'thịt ếch lớn', '2 con', 1),
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', '1/2 củ hành tây', 'hành tây', '1/2 củ', 1),
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', '20 g rau răm', 'rau răm', '20 g', 1),
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', '1 mc sả bào', 'mc sả bào', '1', 1),
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', '1 chén nước', 'nước', '1 chén', 1),
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', '2 mc nước mắm', 'mc nước mắm', '2', 1),
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', '1 mc nước tương', 'mc nước tương', '1', 1),
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', '1/3 mcf hạt nêm', 'mcf hạt nêm', '1/3', 1),
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', 'Ít tiêu xay và tỏi phi', 'ít tiêu xay và tỏi phi', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', 1, 'Ếch chặt sẵn, bóp muối rửa sạch. Phi thơm sả bào, cho thịt ếch vào đảo săn', 'https://img-global.cpcdn.com/steps/d4e5758129e47de7/400x400cq80/photo.jpg'),
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', 2, 'Thêm nước và các gia vị, kho nhỏ lửa cho ếch thấm gia vị, tiếp tục cho hành tây cắt múi cau vào, hành chín thì cho rau răm', 'https://img-global.cpcdn.com/steps/7dfd3a267079ab26/400x400cq80/photo.jpg'),
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', 3, 'Đảo đều và thêm tiêu xay, tỏi phi', 'https://img-global.cpcdn.com/steps/ebc0273bc8488bab/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', 300, 15.0, 31.0, 10.0, 6.5, 64.1, 4.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('92f66b0b-e3fa-480d-a1cf-ea00313d4b34', 'món kho');

-- Món ăn: Ếch xào sả ớt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 'Ếch xào sả ớt', 'Đi chợ hoài ko biết ăn gì. Thì nay e nấu thử món thịt ếch xào sả ớt. Cũng hao cơm lắm 😅', 'https://img-global.cpcdn.com/recipes/31a3f80d22e4e54e/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người ăn', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/26456606', 'Huynh Anh')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 'Ếch', 'ếch', 'Tùy lượng', 1),
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 'Sả', 'sả', 'Tùy lượng', 1),
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 'Ớt', 'ớt', 'Tùy lượng', 1),
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 'Tỏi', 'tỏi', 'Tùy lượng', 1),
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 'Nước mắm', 'nước mắm', 'Tùy lượng', 1),
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 'Bột ngọt', 'bột ngọt', 'Tùy lượng', 1),
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 'Muối', 'muối', 'Tùy lượng', 1),
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 'Nghệ', 'nghệ', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 1, 'Ếch sống làm sạch, cắt miếng vừa ăn. Rửa với muối, qua 2-3 nước cho sạch. Ướp với 1 muỗng nước mắm khoảng 45'' cho thấm vào thịt', 'https://img-global.cpcdn.com/steps/840514cb67ddfc17/400x400cq80/photo.jpg'),
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 2, 'Tỏi, nghệ, sả, ớt băm nhuyễn', 'https://img-global.cpcdn.com/steps/bef7f96299229246/400x400cq80/photo.jpg'),
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 3, 'Cho thịt ếch lên chiên sơ cho hơi vàng rồi tắt bếp', 'https://img-global.cpcdn.com/steps/e7c69005c016249c/400x400cq80/photo.jpg'),
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 4, 'Đổ dầu ăn vào chảo khác, chảo nóng thì cho tỏi sả nghệ và ớt và đảo đều cho sả hơi săn, tiếp tục đổ ếch vào đảo đều, thêm xíu nước mắm, bột ngọt nêm vừa ăn rồi tắt bếp. Cho ra dĩa và dứt thoay 😋😋😋', 'https://img-global.cpcdn.com/steps/a84fdfcbc11ddbb6/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 300, 15.0, 25.0, 10.0, 3.0, 70.6, 1.6)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('cf57f0e6-2933-4564-b5c8-aebdc1d8eab4', 'món xào');

-- Món ăn: Ếch Núp Rơm (Ếch Núp Lùm)
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 'Ếch Núp Rơm (Ếch Núp Lùm)', 'Lần đầu làm tại nhà món Ếch núp rơm. Món ăn miền Tây độc đáo, hấp dẫn từ thị giác đến hương vị. Thịt ếch tẩm ướp đậm đà, chiên giòn rụm, phủ kín bởi lớp sợi sả chiên vàng ươm tơi xốp như đống rơm khô. Khi thưởng thức, thịt ếch ngọt mềm quyện cùng vị sả thơm giòn, cay nhẹ, chấm thêm mắm me chua ngọt cực kỳ "tốn mồi". #2026cookpadapron', 'https://img-global.cpcdn.com/recipes/d5730a6ded23bb96/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25889754', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', '5 con (khoảng 1kg) Ếch làm sạch', 'ếch làm sạch', '5 con', 1),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', '5 cây Sả cây', 'sả cây', '5 cây', 1),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', '6 lá húng quế hoặc rau răm', 'á húng quế hoặc rau răm', '6 l', 1),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', '1 muỗng cà phê Nghệ bột', 'nghệ bột', '1 muỗng cà phê', 1),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', '1/2 muỗng cà phê Muối', 'muối', '1/2 muỗng cà phê', 1),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', '100 g Bột chiên giòn', 'bột chiên giòn', '100 g', 1),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', '500 ml Dầu ăn', 'dầu ăn', '500 ml', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 1, 'Ếch rửa sạch, cắt làm 4 phần, để ráo.', 'https://img-global.cpcdn.com/steps/132113be3554b6e9/400x400cq80/photo.jpg'),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 2, 'Sả lấy phần non, khoảng 1 gang tay từ gốc, bỏ bớt lớp ngoài già, đập dập, xé thật tơi.', 'https://img-global.cpcdn.com/steps/2eb896da39a68a89/400x400cq80/photo.jpg'),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 3, 'Trộn ếch với xíu muối, tiêu và nghệ bột, để thấm 10 phút.', 'https://img-global.cpcdn.com/steps/c0ca9c69523ef044/400x400cq80/photo.jpg'),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 4, 'Đun nóng dầu, áo sả với 2 muỗng canh bột chiên giòn có gia vị, cho sả vào chiên vàng thơm, vớt ra.', 'https://img-global.cpcdn.com/steps/3ba64013b21ebac5/400x400cq80/photo.jpg'),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 5, 'Sả mau đổi màu vàng đậm nên chiên vừa vàng là vớt ra sẽ vàng thêm. Để ráo dầu.', 'https://img-global.cpcdn.com/steps/025b406c9a349a40/400x400cq80/photo.jpg'),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 6, 'Lăn ếch qua bột chiên giòn cho áo đều. Tiếp tục chiên ếch đến khi vàng giòn, vớt ra để ráo.', 'https://img-global.cpcdn.com/steps/dba6dfb5d0ec970f/400x400cq80/photo.jpg'),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 7, 'Xếp ếch và sả chiên lên dĩa có rau răm, dùng nóng.', 'https://img-global.cpcdn.com/steps/5bbc692a4686dc44/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 400, 15.0, 31.0, 18.0, 6.5, 41.0, 4.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 'món ngon mỗi ngày'),
('b6ccb8a3-8998-449e-a82c-bcba709c4bcf', 'dễ làm');

-- Món ăn: Cháo ếch Singapore
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('4c76943f-0124-4782-8892-bda253da524c', 'Cháo ếch Singapore', 'Cách làm món Cháo ếch Singapore ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/75e2156a7bc1811b/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/25585117', 'Uyen Ngoc Bui')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('4c76943f-0124-4782-8892-bda253da524c', '2 kg Ếch', 'ếch', '2 kg', 1),
('4c76943f-0124-4782-8892-bda253da524c', '2 kg xương gà', 'xương gà', '2 kg', 1),
('4c76943f-0124-4782-8892-bda253da524c', '50 g gừng đập dập', 'gừng đập dập', '50 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '50 g hành tím', 'hành tím', '50 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '500 g Gạo', 'gạo', '500 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '150 g đường phèn', 'đường phèn', '150 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '100 g bột canh', 'bột canh', '100 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '100 g bột ngọt', 'bột ngọt', '100 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '100 g Dầu ăn', 'dầu ăn', '100 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '50 g tỏi đập dập hoặc bằm', 'tỏi đập dập hoặc bằm', '50 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '50 g hành tím', 'hành tím', '50 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '30 g gừng bằm nhuyễn', 'gừng bằm nhuyễn', '30 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '150 g Dầu hào', 'dầu hào', '150 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '60 g xì dầu đậm đặc Maggi', 'xì dầu đậm đặc maggi', '60 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '70 g hắc xì dầu Leekimkee', 'hắc xì dầu leekimkee', '70 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '10 g bột ngọt', 'bột ngọt', '10 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '10 g hạt nêm', 'hạt nêm', '10 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '5 g bột canh', 'bột canh', '5 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '50 g tương ớt', 'tương ớt', '50 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '150 g nước dùng gà', 'nước dùng gà', '150 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '10 g sả bào', 'sả bào', '10 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '4 g gừng sợi', 'gừng sợi', '4 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '100 g sốt rim', 'sốt rim', '100 g', 1),
('4c76943f-0124-4782-8892-bda253da524c', '1 mcafe bơ Tường an', 'mcafe bơ tường an', '1', 1),
('4c76943f-0124-4782-8892-bda253da524c', '2 mcafe Dầu điều, 1/2 mcafe màu ghạch tôm', 'mcafe dầu điều, 1/2 mcafe màu ghạch tôm', '2', 1),
('4c76943f-0124-4782-8892-bda253da524c', 'Xíu ớt Hàn Quốc', 'xíu ớt hàn quốc', 'Tùy lượng', 1),
('4c76943f-0124-4782-8892-bda253da524c', 'ớt trái khô :4/5 trái', 'ớt trái khô', '4/5 trái', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('4c76943f-0124-4782-8892-bda253da524c', 1, 'Sơ chế Ếch 2kg Ếch (1 kg 4-5 con) mua về rửa sạch với rượu, muối, bỏ mạch máu trong bụng, rửa đến khi nước trong, để ráo, cắt làm 4 cho vào mỗi túi nylon 2 hoặc 3 con Ướp đá', ''),
('4c76943f-0124-4782-8892-bda253da524c', 2, 'Cách nấu cháo tươi kiểu người Tiều 💜Nguyên liệu : 🦚Phần nước dùng gà -2 kg xương gà rửa muối sạch sẽ, trụng bỏ nước đục nấu với 5 lít nước lạnh, hầm 1 tiếng cho vào 1 củ hành tây, 50g gừng đập dập, 50g hành tím, tiếng thứ 2 tắt lửa, lược lấy nước dùng gà (dùng để pha chế cháo và rim ếch)', ''),
('4c76943f-0124-4782-8892-bda253da524c', 3, '🦚 Phần cháo -500g Gạo ngon thơm chợ Đào, vo thật sạch để ráo, ngâm 100g dầu ăn (ngâm 60p) -5 lít nước sôi, cho Gạo vào nấu lửa lớn đến khi gần sệt thì vặn lửa nhỏ, khuấy cho khỏi khét cháo, khi cháo nở sệt đặc thì cho vào 10g muối trắng, tắt lửa (đây là cốt cháo tươi) 💜Nước nêm : 500g nước lạnh 150g đường phèn 100g bột canh 100g bột ngọt Nấu sôi, lọc sạch. 💜Pha chế cháo -300g cháo đặc -100g nước dùng gà -15g nước nêm 👉Cho tất cả vào thố nấu sôi, rắc trang trí mè đen, tiêu.', ''),
('4c76943f-0124-4782-8892-bda253da524c', 4, 'SỐT RIM ẾCH Singapore 🐸 💜Cách làm Chảo nóng cho lần lượt -100g Dầu ăn -50g tỏi đập dập hoặc bằm -50g hành tím đập dập hoặc bằm Tỏi hành phi thơm thì cho : -30g gừng bằm nhuyễn -150g Dầu hào -60g xì dầu đậm đặc Maggi -70g hắc xì dầu Leekimkee -10g bột ngọt -10g hạt nêm -5g bột canh -50g tương ớt -150g nước dùng gà Xào sôi thì tắt lửa cho 20g rượu hoa tiêu và 20g kipchap vào.', ''),
('4c76943f-0124-4782-8892-bda253da524c', 5, '👉Cho ra ca ta được NƯỚC SỐT RIM 💜Chuẩn bị gia vị kèm theo -Dầu mè đen -Dầu màu điều -Nước màu ghạch tôm (pha tỷ lệ 10g bột + 100g nước) - ớt bột Hàn Quốc -Dầu ớt (tạo cay) -Hành lá cắt khúc - Gừng xắt sợi - Sả bào - ớt trái khô - Bơ tường an - Nước dùng gà -Nước bột năng tạo sệt (50g bột năng + 150g nước lạnh, trộn đều)', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('4c76943f-0124-4782-8892-bda253da524c', 360, 33.0, 25.0, 14.0, 3.0, 36.3, 2.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('4c76943f-0124-4782-8892-bda253da524c', 'món ngon mỗi ngày'),
('4c76943f-0124-4782-8892-bda253da524c', 'dễ làm');

-- Món ăn: Lẩu ếch măng cay
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Lẩu ếch măng cay', 'Quá thèm món này mà sống xa nhà chỉ còn cách tự học nấu mà ăn 😭 nhưng mà đảm bảo ngon bất ngờ luôn ạ mọi người ưiii', 'https://img-global.cpcdn.com/recipes/8884c93d97754f85/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25405625', 'Ngọc Huyền')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Ếch đông lạnh do chỗ em chỉ mua được như vậy', 'ếch đông lạnh do chỗ em chỉ mua được như vậy', 'Tùy lượng', 1),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Hộp măng ớt chua cay', 'hộp măng ớt chua cay', 'Tùy lượng', 1),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Măng củ', 'măng củ', 'Tùy lượng', 1),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Tỏi băm và hành băm', 'tỏi băm và hành băm', 'Tùy lượng', 1),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Bột chiên giòn', 'bột chiên giòn', 'Tùy lượng', 1),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Cà chua', 'cà chua', 'Tùy lượng', 1),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Xương gà', 'xương gà', 'Tùy lượng', 1),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Gia vị: mắm, đường, hạt nêm, sate, bột nghệ, mẻ, dầu hào', 'gia vị', 'mắm, đường, hạt nêm, sate, bột nghệ, mẻ, dầu hào', 1),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Hành lá, mùi tàu, lá lốt, tía tô thái nhỏ', 'hành lá, mùi tàu, lá lốt, tía tô thái nhỏ', 'Tùy lượng', 1),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'Đồ nhúng lẩu: rau muống, đậu phụ, váng đậu, bò tuỳ nhu cầu sở thích cá nhân', 'đồ nhúng lẩu', 'rau muống, đậu phụ, váng đậu, bò tuỳ nhu cầu sở thích cá nhân', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 1, 'Ếch bóp qua muối trắng rửa sạch', ''),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 2, 'Măng củ cắt con chì. Luộc măng mở vung cho hoà tan chất độc trong măng, đun vs nghệ tầm 15'' là đc', ''),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 3, 'Phi thơm tỏi, xong vớt ra để riêng tỏi vs dầu', ''),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 4, 'Làm nóng dầu cho ít bột bắp vào r chiên ếch vàng', ''),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 5, 'Nước dùng: Dùng dầu tỏi phi thơm hành tỏi lên cho thơm, cho cà chua mẻ nghệ vào rồi cho măng cay vào xào cùng. Cho hạt nêm, đường, mắm, sate. Cho mẻ để lấy vị chua. Cuối cùng cho cho nước gà hầm xương vào đun, cho cuối để măng ko bị nhạt nhẽo', ''),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 6, 'Ếch xào măng: phi thơm tỏi, cho măng đã luộc vào xào. Cho chút nước vào xào cho đỡ khô. Cho ít hạt nêm, nước mắm, sa tế (nếu thích), dầu hào vs đường vào đảo đều lên. Rồi cho ếch đã chiên vào đảo cùng. Gần ăn thì cho hành lá, mùi tàu, lá lốt cắt khúc vào xào nóng lại.', ''),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 7, 'Nước dùng và ếch xào đều cho hành lá. Mùi tàu, lá lốt cắt khúc và tỏi phi, ớt rắc lên', 'https://img-global.cpcdn.com/steps/3a2cffdb530ece43/400x400cq80/photo.jpg'),
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 8, 'Nước lẩu này ăn với bún hay mì đều toẹt vời hết ạ', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('73731cc7-9127-4a17-b12b-2624d0e7f69c', 520, 33.0, 25.0, 26.0, 3.0, 51.3, 2.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('73731cc7-9127-4a17-b12b-2624d0e7f69c', 'món nước');

-- Món ăn: Ếch xào lá giang, bạc hà chua chua cay cay thơm ngon
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('04830b9f-3c2b-40ca-ad24-f4d345c55733', 'Ếch xào lá giang, bạc hà chua chua cay cay thơm ngon', 'Món ăn từ ếch', 'https://img-global.cpcdn.com/recipes/878a928f2446592c/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người ăn', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/25392679', 'Thy nguyễn')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('04830b9f-3c2b-40ca-ad24-f4d345c55733', '1 kg ếch tươi', 'ếch tươi', '1 kg', 1),
('04830b9f-3c2b-40ca-ad24-f4d345c55733', '1 bó bạc hà', 'bạc hà', '1 bó', 1),
('04830b9f-3c2b-40ca-ad24-f4d345c55733', '1 bó lá giang', 'lá giang', '1 bó', 1),
('04830b9f-3c2b-40ca-ad24-f4d345c55733', '1-2 trái ớt', 'ớt', '1-2 trái', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('04830b9f-3c2b-40ca-ad24-f4d345c55733', 1, 'Rửa sạch cắt ếch miếng vừa miệng ăn. Ướp xíu mắm, bột ngọt, tiêu.', ''),
('04830b9f-3c2b-40ca-ad24-f4d345c55733', 2, 'Rửa lá giang, bóp nát', ''),
('04830b9f-3c2b-40ca-ad24-f4d345c55733', 3, 'Tước vỏ bạc hà rửa sạch cắt lát', ''),
('04830b9f-3c2b-40ca-ad24-f4d345c55733', 4, 'Dập tỏi phi thơm với dầu. Bỏ ếch vào xào cho thắm gia vị. Nước rút lại săn thịt, bỏ rau vào xào xít tắt bếp cắt xíu ớt bỏ lên', 'https://img-global.cpcdn.com/steps/0050ad4f6f65d6f1/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('04830b9f-3c2b-40ca-ad24-f4d345c55733', 300, 15.0, 25.0, 10.0, 3.0, 41.6, 1.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('04830b9f-3c2b-40ca-ad24-f4d345c55733', 'món xào');

-- Món ăn: Ếch núp lùm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('92eccffb-5e75-4d81-8f54-8114960153e6', 'Ếch núp lùm', 'có dịp đi chơi cùng bạn ghé quán ăn món này mà tên nghe cũng hay hôm nay mình làm lại', 'https://img-global.cpcdn.com/recipes/56c23dac37d3d0bc/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25370949', 'Huyen le Tran')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('92eccffb-5e75-4d81-8f54-8114960153e6', '3 con ếch 300g mỗi con', 'ếch 300g mỗi con', '3 con', 1),
('92eccffb-5e75-4d81-8f54-8114960153e6', '1 gói bột áo khô', 'ói bột áo khô', '1 g', 1),
('92eccffb-5e75-4d81-8f54-8114960153e6', '6 tép sả', 'sả', '6 tép', 1),
('92eccffb-5e75-4d81-8f54-8114960153e6', '2mc nước mắm', 'mc nước mắm', '2', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('92eccffb-5e75-4d81-8f54-8114960153e6', 1, 'Ếch làm chừa da trụn nước sôi cạo rửa sạch để ráo. Sả chỉ lấy phần non rửa sạch', 'https://img-global.cpcdn.com/steps/a143ff9f11b73fac/400x400cq80/photo.jpg'),
('92eccffb-5e75-4d81-8f54-8114960153e6', 2, 'Sả đập dập thành sợi áo bột khô rồi đem chiên giòn', 'https://img-global.cpcdn.com/steps/4e404054303d0588/400x400cq80/photo.jpg'),
('92eccffb-5e75-4d81-8f54-8114960153e6', 3, 'Ếch đem rửa qua nước mắm để ráo áo qua lớp bột khô chien giòn.', 'https://img-global.cpcdn.com/steps/03a7e99e86cc4b22/400x400cq80/photo.jpg'),
('92eccffb-5e75-4d81-8f54-8114960153e6', 4, 'Cho ếch vào dĩa phủ lớp sả lên điểm vài cọng cỏ', 'https://img-global.cpcdn.com/steps/2f4b2ff8de574b39/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('92eccffb-5e75-4d81-8f54-8114960153e6', 300, 15.0, 25.0, 10.0, 3.0, 66.4, 2.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('92eccffb-5e75-4d81-8f54-8114960153e6', 'món ngon mỗi ngày'),
('92eccffb-5e75-4d81-8f54-8114960153e6', 'dễ làm');

-- Món ăn: Ếch kho Singapore
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 'Ếch kho Singapore', 'Lạnh lạnh mà có một thố ếch kho thì quá đãaa. Cùng làm với mình nhé!!', 'https://img-global.cpcdn.com/recipes/44e6f240886bba73/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25173120', 'Trung Nguyen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '400 gr ếch', 'r ếch', '400 g', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1 muỗng canh dầu mè', 'dầu mè', '1 muỗng canh', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1 muỗng canh hắc xì dầu', 'hắc xì dầu', '1 muỗng canh', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1 muỗng canh bột bắp', 'bột bắp', '1 muỗng canh', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1/2 muỗng cà phê tiêu', 'tiêu', '1/2 muỗng cà phê', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1 nhánh gừng nhỏ', 'gừng nhỏ', '1 nhánh', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '4 tép tỏi', 'tỏi', '4 tép', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '4 trái ớt', 'ớt', '4 trái', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 'Hành lá', 'hành lá', 'Tùy lượng', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1 muỗng canh đường', 'đường', '1 muỗng canh', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1 muỗng canh nước tương', 'nước tương', '1 muỗng canh', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1 muỗng canh dầu hào', 'dầu hào', '1 muỗng canh', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1 muỗng canh hắt xì dầu', 'hắt xì dầu', '1 muỗng canh', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1 muỗng canh rượu', 'rượu', '1 muỗng canh', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1/3 muỗng canh muối', 'muối', '1/3 muỗng canh', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', '1 nhúm tiêu xay', 'nhúm tiêu xay', '1', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 'Ớt bột cayenne', 'ớt bột cayenne', 'Tùy lượng', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 'Ớt khô', 'ớt khô', 'Tùy lượng', 1),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 'Nước lọc', 'nước lọc', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 1, 'Rửa sạch ếch với muối cho sạch thì ướp với gia vị ướp nêu trên trong 20phút', ''),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 2, 'Xào gia vị lên cho thơm thì cho ếch vào xào chung rồi thêm gia vị kho vào chung và kho đến khi nước cạn và sệt sệt lại là được. Nhớ nêm nếm gia vị lại cho phù hợp với bản thân trong lúc thêm gia vị vào là ok.', ''),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 3, 'Ăn chung với bánh mì hoặc cháo thịt bằm là hết sẩy', ''),
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 4, 'Chúc mọi người ngon miệng 😋', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 300, 15.0, 25.0, 10.0, 3.0, 44.4, 3.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('4e10a681-4ef7-48aa-b0dc-fb8f82a8b3ee', 'món kho');

-- Món ăn: Lẩu Ếch Măng Cay 🌶️
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('1ac0fdc5-7aab-4bf6-b002-921c53203160', 'Lẩu Ếch Măng Cay 🌶️', '#cookpadapron2025 măng Gọi là lẩu nhưng lẩu này nấu siêu nhanh, ếch được làm sẵn nên nấu cũng lẹ. Món này phù hợp cuối tuần, ngày mưa lạnh lắm nè! Mình mời cả nhà làm thử nha!', 'https://img-global.cpcdn.com/recipes/b3fdac51e2dc189e/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 phần', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25062472', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '1 kí ếch (đã làm sạch)', 'kí ếch', '1', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '2 quả cà chua', 'cà chua', '2 quả', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '300 gr măng lay', 'r măng lay', '300 g', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '10 cái nấm hương, ngâm nở', 'nấm hương, ngâm nở', '10 cái', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '1/4 quả dứa', 'dứa', '1/4 quả', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '4 cây sả', 'sả', '4 cây', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '1 tbsp màu dầu điều', 'màu dầu điều', '1 tbsp', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '1 tsp bột nghệ', 'bột nghệ', '1 tsp', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '1/2 củ hành tây, xắt lát', 'hành tây, xắt lát', '1/2 củ', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '2 quả dừa', 'dừa', '2 quả', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '1 muỗng canh sa tế', 'sa tế', '1 muỗng canh', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '1 quả ớt sừng', 'ớt sừng', '1 quả', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '100 gr măng ngâm mắc mật (tuỳ ý)', 'r măng ngâm mắc mật', '100 g', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '1 nắm lá lốt, tía tô, mùi tàu', 'lá lốt, tía tô, mùi tàu', '1 nắm', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '1 ít mẻ hoặc dấm', 'mẻ hoặc dấm', '1 ít', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '2 tbsp bột chiên giòn hoặc bột bắp', 'bột chiên giòn hoặc bột bắp', '2 tbsp', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '500 gr Bún tươi', 'r bún tươi', '500 g', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '500 gr rau ăn kèm: rau muống, hoa chuối, nấm tuỳ ý', 'r rau ăn kèm: rau muống, hoa chuối, nấm tuỳ ý', '500 g', 1),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', '1 ít Gia vị thông thường: muối, đường, nước mắm', 'gia vị thông thường: muối, đường, nước mắm', '1 ít', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('1ac0fdc5-7aab-4bf6-b002-921c53203160', 1, 'Đầu tiên làm ếch vì cần thời gian thấm gia vị: ếch nhờ người bán lột da (nếu không thích da) bỏ ruột. Mình đem về rửa với nước muối, dấm. Để ráo. Cắt làm 4. Ướp ếch với 1 tbsp nước mắm, 1/4 tsp muối, 1 tsp bột nghệ, 1 tbsp hành tỏi phi hoặc 1 ít hành tỏi bột, sả băm hoặc bột sả. Để ngấm ít nhất 30 phút.', 'https://img-global.cpcdn.com/steps/e8d105e37827dc6d/400x400cq80/photo.jpg'),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', 2, 'Măng luộc với nước sôi, để ráo xắt sợi vừa ăn.', 'https://img-global.cpcdn.com/steps/afcf66ec82107270/400x400cq80/photo.jpg'),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', 3, 'Chuẩn bị rửa sạch sẽ các loại rau nấu/ăn kèm: muống, chuối bào, lá lốt, tía tô, mùi tàu, sả, cà chua, …', 'https://img-global.cpcdn.com/steps/caa11e8ff2096c47/400x400cq80/photo.jpg'),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', 4, 'Lăn ếch qua bột chiên giòn, cho vào chảo nhiều dầu, chiên tới khi vàng các mặt vớt ra để ráo dầu. Có thể dùng nckd nhưng ếch sẽ khô hơn.', 'https://img-global.cpcdn.com/steps/b2365b9a331493e5/400x400cq80/photo.jpg'),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', 5, 'Phi thơm ít hành tỏi băm xào măng với xíu muối cho thấm. Xếp măng và ếch chiên lên đĩa, thêm ít rau thơm lên trên.', 'https://img-global.cpcdn.com/steps/bc56678fdb6c2cb2/400x400cq80/photo.jpg'),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', 6, 'Nấu nước lẩu: phi thơm hành tỏi sả đập dập, cho thơm và cà chua, hành tây, nấm hương, dầu điều vào xào. Thêm nước của 2 trái dừa, thêm nước lọc sao cho thành 2 lít nước lẩu. Bước này có măng ngâm sẽ thêm vào, thêm ít vị chua. Còn không có măng ngâm thì bỏ qua. Nêm lại với đường, mẻ, nước mắm cuối cùng sao cho chua mặn ngọt vừa ăn. Sa tế hay ớt cay cũng tuỳ ý gia giảm.', 'https://img-global.cpcdn.com/steps/19a3eec953b8079a/400x400cq80/photo.jpg'),
('1ac0fdc5-7aab-4bf6-b002-921c53203160', 7, 'Dọn kèm nước mắm ớt, rau nhúng các loại, bún tươi. Khi ăn nhúng rau chín, thêm ếch vào chan nước lẩu nóng lên thưởng thức! 🥰', 'https://img-global.cpcdn.com/steps/5950a5780c9cef69/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('1ac0fdc5-7aab-4bf6-b002-921c53203160', 520, 15.0, 61.0, 18.0, 6.5, 70.6, 4.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('1ac0fdc5-7aab-4bf6-b002-921c53203160', 'món nước');

-- Món ăn: Ếch Xào Rau Cần Nước
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', 'Ếch Xào Rau Cần Nước', 'Món ếch xào rau cần nước là một đặc sản của miền Tây. Món ăn có sự kết hợp hài hòa giữa vị ngọt, dai của thịt ếch đồng và độ giòn, thanh mát đặc trưng của rau cần nước. Gia vị nêm nếm đậm đà cùng mùi thơm của tỏi phi làm tăng thêm hương vị hấp dẫn. #cookpadapron2025', 'https://img-global.cpcdn.com/recipes/ffd61276e0b3e1dd/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/17116705', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', '500 gr Ếch đồng làm sạch', 'r ếch đồng làm sạch', '500 g', 1),
('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', '200 gr Cần nước', 'r cần nước', '200 g', 1),
('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', '1 tbsp Tỏi băm', 'tỏi băm', '1 tbsp', 1),
('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', '1 chén Nước tương dằm ớt', 'nước tương dằm ớt', '1 chén', 1),
('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', 'Gia vị: dầu ăn, muối, tiêu, đường', 'gia vị', 'dầu ăn, muối, tiêu, đường', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', 1, 'Rau cần nước là rau thuỷ canh nên mình ít khi ăn sống. Mình sẽ lặt cọng to để riêng xào trước vì lâu chín hơn. Rửa sạch để ráo.', 'https://img-global.cpcdn.com/steps/d7fdb066bb440d0e/400x400cq80/photo.jpg'),
('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', 2, 'Ếch ướp 1/4 tsp muối, xíu tiêu xíu đường, ít tỏi băm để thấm 15 phút.', 'https://img-global.cpcdn.com/steps/aa9075ba8d8b4669/400x400cq80/photo.jpg'),
('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', 3, 'Phi thơm tỏi xào ếch chín tới (thịt trắng đục săn lại) rồi thêm cọng to trước, rồi tới lá rau cần đảo vài dạo rau xèo xuống là được. Nêm xíu nước tương.', 'https://img-global.cpcdn.com/steps/9cbd66c45183bd9d/400x400cq80/photo.jpg'),
('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', 4, 'Ăn kèm nước tương dằm ớt siêu ngon.', 'https://img-global.cpcdn.com/steps/5fb3e6d416227981/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', 300, 15.0, 31.0, 10.0, 6.5, 43.2, 3.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('4e0f5cf5-4e7c-4f6a-8600-c70a4e8549a9', 'món xào');

-- Món ăn: Cà Ri Đùi Ếch Chôm Chôm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', 'Cà Ri Đùi Ếch Chôm Chôm', '#CookpadApron2025 #Tuan16 #ChomChom Lại một lần nữa, mình đưa một nguyên liệu thường xuất hiện trong các món ngọt, món tráng miệng vào một món mặn. Đó chính là “chôm chôm”. Ở món ăn này, đùi ếch hợp với vị ngọt dịu của chôm chôm và vị béo thơm của nước cốt dừa quyện mùi cà ri, thêm chút chua nhẹ của nước cốt chanh tươi đã làm món ăn trở nên sáng vị và đỡ ngán! Còn phần rễ ngò giã nhuyễn đã tạo nên mùi thơm theo kiểu rất Đông Nam Á; sốt cà ri dầu lại giúp món ăn tăng màu và có độ đậm đà… Lá cà ri tươi và lá chanh Kaffir lại góp phần tạo nên mùi thơm dịu đặc trưng khiến món ăn dậy mùi khi nấu nóng. #CaRiDuiEchChomChom #HuynhPhatKitchen', 'https://img-global.cpcdn.com/recipes/24c096892f4b5960/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24894272', 'Huỳnh Phát')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '600 gam đùi Ếch', 'am đùi ếch', '600 g', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '20 trái Chôm Chôm', 'chôm chôm', '20 trái', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '2 tbsp cà ri bột', 'cà ri bột', '2 tbsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '1 tbsp cà ri dầu', 'cà ri dầu', '1 tbsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '1.5 tsp bột nghệ', 'bột nghệ', '1.5 tsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '350 ml nước cốt dừa (nước dão)', 'nước cốt dừa', '350 ml', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '150 ml nước cốt dừa đặc (nước cốt)', 'nước cốt dừa đặc', '150 ml', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '1 cây sả', 'sả', '1 cây', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '2 tbsp hành tím băm', 'hành tím băm', '2 tbsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '2 tbsp tỏi băm', 'tỏi băm', '2 tbsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '1.5 tbsp gừng băm', 'gừng băm', '1.5 tbsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '1 tbsp ớt sừng băm', 'ớt sừng băm', '1 tbsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '1 tbsp rễ ngò giã nhuyễn', 'rễ ngò giã nhuyễn', '1 tbsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '6 chiếc lá Chanh Kaffir', 'chiếc lá chanh kaffir', '6', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '1 tbsp nước cốt chanh', 'nước cốt chanh', '1 tbsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '2 nhánh lá Cà ri', 'lá cà ri', '2 nhánh', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '1 tsp muối', 'muối', '1 tsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '1 tsp tiêu', 'tiêu', '1 tsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '2 tbsp nước mắm', 'nước mắm', '2 tbsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '3 tbsp đường vàng', 'đường vàng', '3 tbsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '1 tsp bột ngọt', 'bột ngọt', '1 tsp', 1),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', '3 tbsp dầu màu điều', 'dầu màu điều', '3 tbsp', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', 1, 'Đùi ếch rửa với rượu, gừng, muối, sau đó rửa qua nước lạnh rồi để ráo cho sạch mùi… Chôm chôm lột vỏ, bỏ hột, chừa lại phần cơm (cố gắng giữ nguyên vẹn).', 'https://img-global.cpcdn.com/steps/f890d75629d5ccc1/400x400cq80/photo.jpg'),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', 2, 'Ướp đùi ếch với: 1tsp muối + 1tsp tiêu + 1tbsp nước mắm + 1/2tbsp gừng băm + 1tbsp hành tím băm + 1tbsp tỏi băm + 1tbsp rễ ngò giã nhuyễn + 1tbsp cà ri bột + 1/2tbsp cà ri dầu + 1tsp bột nghệ... Trộn thật đều và để khoảng 10–15 phút cho thấm.', 'https://img-global.cpcdn.com/steps/1fb165c7b11e4b86/400x400cq80/photo.jpg'),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', 3, 'Bắc chảo lên bếp, cho vô chảo 3tbsp dầu màu điều. Sả lấy phần gốc, cắt khúc, đập giập cho vô chảo dầu đang nóng để phi. Khi sả đã thơm, ta cho: 1tbsp tỏi băm + 1tbsp hành tím băm + 1tbsp gừng băm + 1tbsp ớt sừng băm vô phi chung cho thơm… Sau đó, ta trút toàn bộ số đùi ếch đã ướp vô chảo, xào trên lửa lớn.', 'https://img-global.cpcdn.com/steps/616977749ddffc6a/400x400cq80/photo.jpg'),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', 4, 'Khi ếch đã săn lại, ta cho: 1/2tbsp cà ri dầu + 1tbsp cà ri bột + 1 nhánh lá cà ri vô chảo. Đảo lên cho đều rồi cho 350ml nước cốt dừa (phần nước dão) vô nấu khoảng 12 phút. Khi nước dừa sôi lên thì ta hạ lửa nhỏ vừa để nấu. Tiếp theo, ta cho hết phần chôm chôm đã tách hột vô nấu chung…', 'https://img-global.cpcdn.com/steps/0f90f91a061f4dc1/400x400cq80/photo.jpg'),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', 5, 'Nấu thêm khoảng 2 phút, ta cho nhánh lá cà ri thứ 2 và lá chanh Kaffir xé miếng nhỏ vô nồi cà ri… Cho 1tbsp nước mắm + 3tbsp đường + 1tsp bột ngọt + 1tbsp nước cốt chanh tươi vô nồi cà ri. Nêm nếm lại cho vừa ăn thì cho 150ml nước cốt dừa (phần nước cốt) vô nấu thêm 1 phút nữa thì ta tắt bếp. Múc món ăn ra tô, trang trí vài lát ớt sừng và 1 nhánh rau húng quế rồi dọn lên. Món này có thể ăn với bánh mì, bún và cơm nóng đều rất ngon…', 'https://img-global.cpcdn.com/steps/3c18009db94a3785/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', 300, 15.0, 25.0, 10.0, 3.0, 38.5, 3.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', 'món ngon mỗi ngày'),
('e29d7fc5-6ee0-4cbe-ad42-3fdaca2a24e5', 'dễ làm');

-- Món ăn: Ếch xào bơ tỏi hành tây
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('8dabf675-cb90-4aa3-8789-be08b4ef52f3', 'Ếch xào bơ tỏi hành tây', 'Cách làm món Ếch xào bơ tỏi hành tây ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/6120a2c3f3dd5e00/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/24839602', 'Manh’s Kitchen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '500 g ếch, đùi ếch', 'ếch, đùi ếch', '500 g', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '60 g bột chiên giòn', 'bột chiên giòn', '60 g', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '50 ml nước đá lạnh', 'nước đá lạnh', '50 ml', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '2 tsp dầu màu điều', 'dầu màu điều', '2 tsp', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', 'Gia vị:bột tỏi,bột ngũ vị hương,hạt nêm,tiêu,dầu hào,nước mắm', 'gia vị', 'bột tỏi,bột ngũ vị hương,hạt nêm,tiêu,dầu hào,nước mắm', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '4 tép tỏi băm,rửa qua giấm để hết nhựa và giòn lâu hơn', 'tỏi băm,rửa qua giấm để hết nhựa và giòn lâu hơn', '4 tép', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '1 củ hành tây, cắt múi cau', 'hành tây, cắt múi cau', '1 củ', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '20 g bơ thực vật', 'bơ thực vật', '20 g', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '1 tbsp nước mắm', 'nước mắm', '1 tbsp', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '1 tbsp dầu hào', 'dầu hào', '1 tbsp', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '1/2 tbsp tương cà', 'tương cà', '1/2 tbsp', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '1/2 tbsp tương ớt', 'tương ớt', '1/2 tbsp', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '1 tsp nước cốt chanh', 'nước cốt chanh', '1 tsp', 1),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', '2 1/2 tbsp đường', 'đường', '2 1/2 tbsp', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', 1, 'Ếch rửa sạch,ướp gia vị 30’.Pha bột chiên giòn(trừ 1tbsp) và nước đá lạnh,cho vào ếch trộn đều,cho 1tbsp bột chiên giòn vào tỏi băm đã rửa sạch', ''),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', 2, 'Chuẩn bị chảo dầu nóng,cho tỏi vào chiên đến khi vàng,đổ ra rây có chén riêng để dầu.Cho dầu chiên tỏi trở lại chảo,cho ếch vào chiên vàng', ''),
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', 3, 'Xào thơm hành tây,sau đó cho ếch đã chiên,sốt xào và bơ vào xào đến khi bám đều bơ và gia vị,cho tỏi vào sau cùng.Dùng nóng', 'https://img-global.cpcdn.com/steps/e0111ab80fcc275d/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('8dabf675-cb90-4aa3-8789-be08b4ef52f3', 400, 15.0, 25.0, 18.0, 3.0, 61.3, 3.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('8dabf675-cb90-4aa3-8789-be08b4ef52f3', 'món xào');

-- Món ăn: Ếch Nướng Chao
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', 'Ếch Nướng Chao', 'Ếch thì mình cũng nhiều lần ăn rồi nhưng tự nấu thì đây là lần đầu. Đi siêu thị thấy vỉ ếch cũng tươi nên mua làm thử. Ướp chao có sẵn và nướng bằng NCKD thôi, ăn cũng dai ngon. #cookpadapron2025', 'https://img-global.cpcdn.com/recipes/a1db89acd3ebc2d6/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24813777', 'Bòn Bon')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', '4 con ếch làm sạch', 'ếch làm sạch', '4 con', 1),
('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', '2 muỗng sốt chao (xay 1 viên chao, hành tỏi băm, dầu điều, 1 tsp đường)', 'sốt chao', '2 muỗng', 1),
('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', '1 ít rau thơm ăn kèm', 'rau thơm ăn kèm', '1 ít', 1),
('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', '1 tbsp muối ớt xanh', 'muối ớt xanh', '1 tbsp', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', 1, 'Ếch rửa dấm muối để ráo ướp sốt chao 20 phút', 'https://img-global.cpcdn.com/steps/8cdbcedfffdeede1/400x400cq80/photo.jpg'),
('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', 2, 'Cho vào nồi chiên không dầu 200 độ 15 phút có lật mặt.', 'https://img-global.cpcdn.com/steps/310113f5581f94c5/400x400cq80/photo.jpg'),
('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', 3, 'Chấm kèm muối ớt, ăn kèm rau thơm.', 'https://img-global.cpcdn.com/steps/b53dd93ac4920136/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', 400, 15.0, 31.0, 18.0, 6.5, 51.4, 2.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', 'món ngon mỗi ngày'),
('6ba52d8d-766e-4d96-9d15-5b8a3ba16f4a', 'dễ làm');

-- Món ăn: Ếch Kho Rau Răm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('4c8f1120-a453-446a-ad6b-83530ef6136e', 'Ếch Kho Rau Răm', '#CookpadApron2025 Tuần 11', 'https://img-global.cpcdn.com/recipes/b67a145423940007/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 phần ăn', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/24564520', 'Rose Truong')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('4c8f1120-a453-446a-ad6b-83530ef6136e', '1/2 kg thịt ếch', 'thịt ếch', '1/2 kg', 1),
('4c8f1120-a453-446a-ad6b-83530ef6136e', '3 muỗng mắm', 'mắm', '3 muỗng', 1),
('4c8f1120-a453-446a-ad6b-83530ef6136e', '2 muỗng đường', 'đường', '2 muỗng', 1),
('4c8f1120-a453-446a-ad6b-83530ef6136e', '3 muỗng mỡ', 'mỡ', '3 muỗng', 1),
('4c8f1120-a453-446a-ad6b-83530ef6136e', '1 muỗng cafe tỏi bằm', 'cafe tỏi bằm', '1 muỗng', 1),
('4c8f1120-a453-446a-ad6b-83530ef6136e', '1 muỗng cafe hành tím bằm', 'cafe hành tím bằm', '1 muỗng', 1),
('4c8f1120-a453-446a-ad6b-83530ef6136e', '1 muỗng cafe ớt bằm', 'cafe ớt bằm', '1 muỗng', 1),
('4c8f1120-a453-446a-ad6b-83530ef6136e', '1 chén rau răm, hành lá, ngỗ (tuỳ thích)', 'rau răm, hành lá, ngỗ', '1 chén', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('4c8f1120-a453-446a-ad6b-83530ef6136e', 1, 'Chuẩn bị các nguyên liệu sẵn sàng sạch sẽ để ráo', 'https://img-global.cpcdn.com/steps/92cd992c4933e2dc/400x400cq80/photo.jpg'),
('4c8f1120-a453-446a-ad6b-83530ef6136e', 2, 'Cho mỡ, tỏi, hành tím, ớt vào phi cho dậy mùi thơm, tắt bếp, rồi cho ếch và gia vị trộn đều nếu không vội để 30 phút cho thấm gia vị', 'https://img-global.cpcdn.com/steps/deb16b53edcbe4ca/400x400cq80/photo.jpg'),
('4c8f1120-a453-446a-ad6b-83530ef6136e', 3, 'Rối nấu sôi lên vớt thật sạch bọt nếu có', 'https://img-global.cpcdn.com/steps/16201ba268131ff4/400x400cq80/photo.jpg'),
('4c8f1120-a453-446a-ad6b-83530ef6136e', 4, 'Khi ếch chín cạn còn lại ít nước thì nêm nếm lại cho vừa khẩu vị, thả rau răm, hành lá, ngỗ vào', 'https://img-global.cpcdn.com/steps/274d4adc24e6b130/400x400cq80/photo.jpg'),
('4c8f1120-a453-446a-ad6b-83530ef6136e', 5, 'Rồi múc ra dĩa sâu lòng. Món này ăn cơm hoặc cháo trắng đều ngon.', 'https://img-global.cpcdn.com/steps/62e051b436229371/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('4c8f1120-a453-446a-ad6b-83530ef6136e', 300, 15.0, 31.0, 10.0, 6.5, 37.1, 4.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('4c8f1120-a453-446a-ad6b-83530ef6136e', 'món kho');

-- Món ăn: Cháo ếch 🐸
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('5a01abd3-1e75-491d-857e-55e51bd5fb17', 'Cháo ếch 🐸', 'Trời lạnh lạnh. Bát cháo nóng thêm tỏi phi vàng. Nồi ếch vị truyền thống cay mặn ôi nó đã gì đâu 🥹', 'https://img-global.cpcdn.com/recipes/897e006d741f5731/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/24526410', 'Amy Ruan')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 'Mình lười ghi nguyên liệu quá. Mọi người cứ đọc cách làm rồi tới loai nào không có thì ghi ra ngoài dù gì cũng phải đi mua ☺️', 'mình lười ghi nguyên liệu quá. mọi người cứ đọc cách làm rồi tới loai nào không có thì ghi ra ngoài dù gì cũng phải đi mua', 'Tùy lượng', 1),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 'gạo', 'gạo', 'Tùy lượng', 1),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 'ếch', 'ếch', 'Tùy lượng', 1),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 'nước màu, đầu hành,', 'nước màu, đầu hành', 'Tùy lượng', 1),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 'rượu trắng, nước tương, hạt nêm,', 'rượu trắng, nước tương, hạt nêm', 'Tùy lượng', 1),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', '30 g bột bắp', 'bột bắp', '30 g', 1),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 'bột hoa tiêu', 'bột hoa tiêu', 'Tùy lượng', 1),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 'ớt khô, tỏi băm, ớt hiểm băm', 'ớt khô, tỏi băm, ớt hiểm băm', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 1, 'Bắt nồi cơm nấu cho gạo dẻo cho nước nhiều tí. Mình thấy nấu cháo từ cơm thì nó ngon và dẻo nhiều.', ''),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 2, 'Ếch đã được sơ chế sạch cho vào tô hoặc thố lớn, nêm vào: nước màu, đầu hành, ớt khô, tỏi băm, ớt hiểm băm, rượu trắng, nước tương, hạt nêm, 30g bột bắp, bột hoa tiêu. Trộn đều tất cả rồi để ướp khoảng 30 phút.', ''),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 3, 'Nước sốt: Pha 15g đường nâu với 150ml nước, giấm gạo, dầu hào, khuấy đều tất cả nguyên liệu trên cho tan hết.', ''),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 4, 'Cơm chín rồi thì bạn lấy ra nồi khác cho thêm nước và tí muối nấu tuỳ ý.', ''),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 5, 'Bắc nồi đất lên bếp, cho 1 thìa canh dầu ăn vào đun nóng thì trút toàn bộ thịt ếch đã ướp vào nồi, xào cho chín đều thì đổ nước xốt vào rồi đun trên lửa nhỏ cho đến khi nước sền sệt thì cho hành lá + gừng thái sợi vào. Rắc thêm một chút tiêu lên trên cho thơm và dọn ra ăn cùng cháo.', ''),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 6, 'Gia vị mình chỉ nói sơ thứ tự nêm nếm. Còn định lượng thì mọi người tự điều chỉnh theo khẩu vị của mình nhé. Chúc mọi người ăn ngon miệng 💋', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('5a01abd3-1e75-491d-857e-55e51bd5fb17', 500, 31.0, 55.0, 14.0, 3.0, 65.7, 3.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 'món ngon mỗi ngày'),
('5a01abd3-1e75-491d-857e-55e51bd5fb17', 'dễ làm');

-- Món ăn: Ếch chiên nước mắm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', 'Ếch chiên nước mắm', '#monlairai Đổi vị với món này rất ngon', 'https://img-global.cpcdn.com/recipes/21027b149ee61d58/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24256633', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', '8 cái đùi ếch', 'đùi ếch', '8 cái', 1),
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', '1 củ hành tây', 'hành tây', '1 củ', 1),
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', '2 cây hành lá', 'hành lá', '2 cây', 1),
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', '1 trái khế', 'khế', '1 trái', 1),
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', '1 mc tỏi băm', 'mc tỏi băm', '1', 1),
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', '2 mc bột chiên giòn', 'mc bột chiên giòn', '2', 1),
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', 'Gia vị', 'gia vị', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', 1, 'Đùi ếch bóp muối rửa sạch, ướp với 1mcf bột nghệ, 1mc hạt nêm, ít tiêu xay trong 30 phút. Thịt ếch thấm thì cho bột chiên giòn vào trộn đều, chiên vàng. Hành tây cắt đôi và cắt múi cau. Khế cắt dài', 'https://img-global.cpcdn.com/steps/eeadf556d82353b5/400x400cq80/photo.jpg'),
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', 2, 'Phi thơm tỏi băm, cho ếch vào đảo đều, thêm 2mc nước mắm, 1mcf đường, 1mc tương ớt, sau đó cho hành tây và khế vào đảo cùng', 'https://img-global.cpcdn.com/steps/cd7b36b65be070d3/400x400cq80/photo.jpg'),
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', 3, 'Cuối cùng thêm hành lá vào, múc ra dĩa và thêm tiêu xay cho thơm', 'https://img-global.cpcdn.com/steps/c0c45eff76384ea1/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', 400, 15.0, 25.0, 18.0, 3.0, 26.7, 3.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('f274b42a-fef0-4ee4-a5ea-6f5f215d5a8c', 'chiên giòn');

-- Món ăn: Ếch chiên cay
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 'Ếch chiên cay', 'Cách làm món Ếch chiên cay ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/19bc150d6f6d1a85/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24249198', 'Manh’s Kitchen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', '10 cái đùi ếch', 'đùi ếch', '10 cái', 1),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', '1 cup bột mì', 'cup bột mì', '1', 1),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', '1 quả trứng', 'trứng', '1 quả', 1),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', '2 tbsp tương ớt', 'tương ớt', '2 tbsp', 1),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 'bột ớt hàn quốc', 'bột ớt hàn quốc', 'Tùy lượng', 1),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 'bột ớt', 'bột ớt', 'Tùy lượng', 1),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 'bột tỏi', 'bột tỏi', 'Tùy lượng', 1),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 'hạt nêm', 'hạt nêm', 'Tùy lượng', 1),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 'bột ớt parpika', 'bột ớt parpika', 'Tùy lượng', 1),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 'nước mắm', 'nước mắm', 'Tùy lượng', 1),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 'bột hành', 'bột hành', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 1, 'Ếch rửa sạch,ướp gia vị và tương ớt 30’', ''),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 2, 'Cho trứng và 1/2 cup bột mì vào ếch trộn đều', ''),
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 3, 'Cho gia vị khô vào phần bột còn lại Cho gà lăn qua bột khô,chiên vàng,dùng nóng 😋', 'https://img-global.cpcdn.com/steps/e824379e56f3f1b6/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 590, 22.0, 55.0, 24.0, 3.0, 58.7, 1.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('4f556b9a-f3f8-491c-b86d-ef7d15ab5b52', 'chiên giòn');

-- Món ăn: Ếch chiên giòn
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('0e7ef8a4-a34c-46f5-af08-0b26612ebdce', 'Ếch chiên giòn', 'Cách làm món Ếch chiên giòn ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/326800601264fa7e/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24217679', 'Manh’s Kitchen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('0e7ef8a4-a34c-46f5-af08-0b26612ebdce', '10 cái đùi ếch', 'đùi ếch', '10 cái', 1),
('0e7ef8a4-a34c-46f5-af08-0b26612ebdce', '20 g bột bắp', 'bột bắp', '20 g', 1),
('0e7ef8a4-a34c-46f5-af08-0b26612ebdce', '80 g bột chiên giòn', 'bột chiên giòn', '80 g', 1),
('0e7ef8a4-a34c-46f5-af08-0b26612ebdce', 'Gia vị: muối,tiêu,hạt nêm,nước mắm,bột hành,bột tỏi', 'gia vị', 'muối,tiêu,hạt nêm,nước mắm,bột hành,bột tỏi', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('0e7ef8a4-a34c-46f5-af08-0b26612ebdce', 1, 'Ếch rửa sạch,ướp gia vị 30’', ''),
('0e7ef8a4-a34c-46f5-af08-0b26612ebdce', 2, 'Cho bột bắp+20g bột chiên giòn vào ếch trộn đều,cho thêm ít nước', ''),
('0e7ef8a4-a34c-46f5-af08-0b26612ebdce', 3, 'Lăn qua bột chiên giòn khô,chiên vàng(chiên 2 lần),dùng nóng 😋', 'https://img-global.cpcdn.com/steps/cdf66de901eec231/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('0e7ef8a4-a34c-46f5-af08-0b26612ebdce', 400, 15.0, 25.0, 18.0, 3.0, 76.5, 4.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('0e7ef8a4-a34c-46f5-af08-0b26612ebdce', 'chiên giòn');

-- Món ăn: Cháo ếch
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('ba282c95-088b-4985-82fe-52538123d341', 'Cháo ếch', '#GlobalApron2024 #globalcookpadgames2024 & #protein Cháo ếch là món ăn xuất phát từ Singapore, mình biến tấu theo cách của mình, gia vị đơn giản hơn nhưng không hề kém ngon nhé.', 'https://img-global.cpcdn.com/recipes/09f33e358e2ec1a7/1200x630cq80/photo.jpg', 30, 'Trung bình', '5 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/23950039', 'Bếp của Quỳnh')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('ba282c95-088b-4985-82fe-52538123d341', '1 kg ếch đồng làm sạch (khoảng 8-9 con)', 'ếch đồng làm sạch', '1 kg', 1),
('ba282c95-088b-4985-82fe-52538123d341', '1 lon gạo', 'on gạo', '1 l', 1),
('ba282c95-088b-4985-82fe-52538123d341', '150 gram lá dứa', 'ram lá dứa', '150 g', 1),
('ba282c95-088b-4985-82fe-52538123d341', '5 nhánh sả', 'sả', '5 nhánh', 1),
('ba282c95-088b-4985-82fe-52538123d341', '1 củ gừng', 'gừng', '1 củ', 1),
('ba282c95-088b-4985-82fe-52538123d341', '5 củ hành tím', 'hành tím', '5 củ', 1),
('ba282c95-088b-4985-82fe-52538123d341', '5 tép tỏi', 'tỏi', '5 tép', 1),
('ba282c95-088b-4985-82fe-52538123d341', '3 quả ớt đỏ', 'ớt đỏ', '3 quả', 1),
('ba282c95-088b-4985-82fe-52538123d341', '5 thìa Dầu ăn', 'dầu ăn', '5 thìa', 1),
('ba282c95-088b-4985-82fe-52538123d341', '7 thìa nước tương', 'nước tương', '7 thìa', 1),
('ba282c95-088b-4985-82fe-52538123d341', 'ớt bột (1 thìa), muối,', 'ớt bột , muối', 'Tùy lượng', 1),
('ba282c95-088b-4985-82fe-52538123d341', '1 thìa tiêu', 'tiêu', '1 thìa', 1),
('ba282c95-088b-4985-82fe-52538123d341', '3 thìa mắm', 'mắm', '3 thìa', 1),
('ba282c95-088b-4985-82fe-52538123d341', '2 thìa kẹo đường', 'kẹo đường', '2 thìa', 1),
('ba282c95-088b-4985-82fe-52538123d341', '3 thìa hạt nêm', 'hạt nêm', '3 thìa', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('ba282c95-088b-4985-82fe-52538123d341', 1, 'Cho chảo lên bếp, cho nước tương vào đun, sôi hạ lửa, thêm đường cho sệt sệt lại (thay cho hắc xì dầu là gia vị cơ bản của cháo ếch), tắt bếp. Xắt tỏi, ớt, gừng thành lát cho vào chảo cùng với ớt bột, hạt nêm, mắm, kẹo đường.', 'https://img-global.cpcdn.com/steps/24cdefddd4688ea8/400x400cq80/photo.jpg'),
('ba282c95-088b-4985-82fe-52538123d341', 2, 'Ướp ếch: Ếch làm sạch, rửa nước muối loãng, để ráo, cho ếch nguyên con vào chảo gia vị, thêm dầu ăn, sả đập dập xắt đoạn, ớt trái rồi trộn đều, ướp ếch khoảng 1 tiếng.', 'https://img-global.cpcdn.com/steps/4c92103cbd128c53/400x400cq80/photo.jpg'),
('ba282c95-088b-4985-82fe-52538123d341', 3, 'Kho ếch: Cho chảo ếch lên bếp, đun sôi và thêm 1 chén nước, đun sôi ở lửa nhỏ, đảo ếch nhẹ nhàng để khỏi bị nát và thấm đều gia vị, nêm gia vị cho vừa ăn, đun khoảng 45 phút thì tắt bếp, cho hành lá lên trên.', 'https://img-global.cpcdn.com/steps/b7bbb597a7f830ed/400x400cq80/photo.jpg'),
('ba282c95-088b-4985-82fe-52538123d341', 4, 'Nấu cháo trắng lá dứa: Trong thời gian ướp ếch thì mình đi nấu nồi cháo trắng (khoảng 1 lon gạo). Lá dứa rửa sạch, xắt đoạn, chần qua nước sôi rồi xay với nước sôi nguội, lọc bỏ bã, lấy phần cốt cho vào nồi cháo khoảng 3 phút thì tắt bếp, nếu để lâu màu lá dứa chuyển vàng úa.', 'https://img-global.cpcdn.com/steps/5f8e50089f97c107/400x400cq80/photo.jpg'),
('ba282c95-088b-4985-82fe-52538123d341', 5, 'Múc cháo lá dứa ra tô, thêm nồi ếch kho, rắc thêm tiêu, hành lá, hành phi, ăn khi còn nóng.', 'https://img-global.cpcdn.com/steps/56b1c9b2fb730b6d/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('ba282c95-088b-4985-82fe-52538123d341', 300, 15.0, 25.0, 10.0, 3.0, 40.1, 2.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('ba282c95-088b-4985-82fe-52538123d341', 'món ngon mỗi ngày'),
('ba282c95-088b-4985-82fe-52538123d341', 'dễ làm');

-- Món ăn: Ếch xào hành tây
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', 'Ếch xào hành tây', '#globalcookpadgames2024 #protein Món ăn ngon, lạ miệng', 'https://img-global.cpcdn.com/recipes/f616413af3cf4e89/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/17273069', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', '5 con ếch', 'ếch', '5 con', 1),
('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', '1 củ hành tây lớn', 'hành tây lớn', '1 củ', 1),
('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', '2 cây hành lá', 'hành lá', '2 cây', 1),
('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', '1 mc hành tỏi xay', 'mc hành tỏi xay', '1', 1),
('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', '2 trái ớt hiểm', 'ớt hiểm', '2 trái', 1),
('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', 'Gia vị', 'gia vị', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', 1, 'Ếch nhờ người bán làm sạch, cắt làm tư, rửa sạch và để ráo. Hành tây bóc vỏ, cắt múi cau. Hành lá bỏ gốc, cắt khúc. Ớt rửa qua cho sạch', ''),
('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', 2, 'Phi thơm hành tỏi băm, cho ếch vào xào săn, thêm nước mắm, đường, hạt nêm, chút nước lọc cho thịt chín', ''),
('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', 3, 'Tiếp đến cho hành tây vào đảo cho hành tây chín và trong lại thì thêm hành lá và ớt, đảo đều và tắt bếp, gắp ra dĩa và rắc ít tiêu xay', 'https://img-global.cpcdn.com/steps/41734de8e5e96155/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', 300, 15.0, 25.0, 10.0, 3.0, 51.6, 2.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('1de6a4c8-7cb0-45c0-a850-b7c0752e4d36', 'món xào');

-- Món ăn: Đùi ếch xào cà tím
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', 'Đùi ếch xào cà tím', 'Cách làm món Đùi ếch xào cà tím ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/5ede55ad4da5de0f/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 phần ăn', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/22549793', 'Khanh Quangmai')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', '1 kg đùi ếch', 'đùi ếch', '1 kg', 1),
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', '1 củ Hành tây,', 'hành tây', '1 củ', 1),
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', '100g lá lốt', 'lá lốt', '100g', 1),
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', '100g Hành lá', 'hành lá', '100g', 1),
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', '2 trái ớt 2 cay', 'ớt 2 cay', '2 trái', 1),
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', '5 tép tỏi', 'tỏi', '5 tép', 1),
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', 'vừng rang,', 'vừng rang', 'Tùy lượng', 1),
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', 'riềng xay,', 'riềng xay', 'Tùy lượng', 1),
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', 'NC mắm, mì chính, hạt nêm, đường, tiêu, bột nghệ,dầu hào, dầu ăn', 'nc mắm, mì chính, hạt nêm, đường, tiêu, bột nghệ,dầu hào, dầu ăn', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', 1, 'Ếch làm sạch ngâm rượu trắng 15p khử tanh, vớt ra để ráo rồi ướp với: đầu thìa cf bột nghệ, 1 thìa phở hạt nêm, 1tcfe mì chính, 1thia phở NC mắm chút tiêu khoảng 20phut. Cà tím chia đều cắt miếng 1 ngón tay, tỏi băm, hành tây cắt múi cau, lá lốt thái rối, hành lá thái vừa.', ''),
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', 2, 'Ếch cho ra rổ ráo nước rồi cho vào chiên vàng đều, cà tím luộc qua', ''),
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', 3, 'Cho chảo lên bếp cùng ít dầu ăn phi tỏi thơm, cho cà tím vào xào rồi cho dầu hào, chút hạt nêm, mì chính đường nc mắm, 1 chút dầu điều tạo màu,tiếp theo cho ếch cùng hành tây vào xào cùng khoảng 5 phút. cho lá lốt + hành lá. Cuối cùng nêm lại gia vị rồi cho ít vừng rang. Xong', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', 420, 15.0, 55.0, 10.0, 3.0, 45.4, 4.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('000ab161-d2e8-4e38-931c-c3d8ce1a1ca2', 'món xào');

-- Món ăn: Tôm và ếch rang
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', 'Tôm và ếch rang', '#MonNongChoMuaLanh Còn mỗi thứ một ít trong tủ lạnh nên mình rang chung để ăn với cơm', 'https://img-global.cpcdn.com/recipes/4b8712ae212a166a/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/17201577', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', '2 con ếch', 'ếch', '2 con', 1),
('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', '200 g tôm', 'tôm', '200 g', 1),
('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', 'Hành tỏi băm', 'hành tỏi băm', 'Tùy lượng', 1),
('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', 'Hành lá', 'hành lá', 'Tùy lượng', 1),
('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', 'Tiêu xay', 'tiêu xay', 'Tùy lượng', 1),
('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', 'Gia vị', 'gia vị', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', 1, 'Phi thơm hành tỏi cho ếch vào đảo săn, ếch săn thì cho tôm vào đảo cho tôm chuyển màu thì thêm muối, đường, nước mắm và nước lọc vào rim tôm và ếch. Cho nhiều nước hơn để ăn với mì', 'https://img-global.cpcdn.com/steps/875a2fa8c270e84d/400x400cq80/photo.jpg'),
('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', 2, 'Múc tôm và ếch ra tô, thêm hành lá cắt nhỏ và tiêu xay vào cho thơm', 'https://img-global.cpcdn.com/steps/2004f4135901f1ba/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', 380, 31.0, 25.0, 14.0, 3.0, 60.9, 2.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', 'món ngon mỗi ngày'),
('a6df63f7-10a5-4628-aed4-e12c06ffcdb0', 'dễ làm');

-- Món ăn: Mì Quảng ếch đơn giản
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('93499278-65ba-4e9f-968c-ce3d7151b24e', 'Mì Quảng ếch đơn giản', '#TapDeVang23', 'https://img-global.cpcdn.com/recipes/18afa8a400f3a59b/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/17201581', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('93499278-65ba-4e9f-968c-ce3d7151b24e', '2 con ếch', 'ếch', '2 con', 1),
('93499278-65ba-4e9f-968c-ce3d7151b24e', '100 g mì lá tươi', 'mì lá tươi', '100 g', 1),
('93499278-65ba-4e9f-968c-ce3d7151b24e', 'Rau ăn kèm (cải con, bắp chuối, rau muống bào)', 'rau ăn kèm', 'Tùy lượng', 1),
('93499278-65ba-4e9f-968c-ce3d7151b24e', 'Bánh đa nướng', 'bánh đa nướng', 'Tùy lượng', 1),
('93499278-65ba-4e9f-968c-ce3d7151b24e', 'Hành lá', 'hành lá', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('93499278-65ba-4e9f-968c-ce3d7151b24e', 1, 'Ếch rang theo công thức này', 'https://img-global.cpcdn.com/steps/01fd843d675d9aa6/400x400cq80/photo.jpg'),
('93499278-65ba-4e9f-968c-ce3d7151b24e', 2, 'Trụng mì lá tươi vào tô, thêm rau sống các loại, thêm ếch và nước chan, thêm bánh đa và rắc hành lá lên trên là xong', 'https://img-global.cpcdn.com/steps/526065ce82ac5bba/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('93499278-65ba-4e9f-968c-ce3d7151b24e', 520, 15.0, 61.0, 18.0, 6.5, 27.8, 1.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('93499278-65ba-4e9f-968c-ce3d7151b24e', 'món ngon mỗi ngày'),
('93499278-65ba-4e9f-968c-ce3d7151b24e', 'dễ làm');

-- Món ăn: Cháo thịt ếch nấm 🍄 lá lốt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('48e0e3d2-b888-401e-ba64-539683ca50fd', 'Cháo thịt ếch nấm 🍄 lá lốt', '#chao #thitech #nam #lalot #andam #bepnhacop', 'https://img-global.cpcdn.com/recipes/95f03b0d18f36d31/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 phần', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/17146499', 'Bếp nhà Cọp')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('48e0e3d2-b888-401e-ba64-539683ca50fd', '25 g gạo', 'gạo', '25 g', 1),
('48e0e3d2-b888-401e-ba64-539683ca50fd', '15 g thịt ếch', 'thịt ếch', '15 g', 1),
('48e0e3d2-b888-401e-ba64-539683ca50fd', '1 cây nấm đùi gà', 'nấm đùi gà', '1 cây', 1),
('48e0e3d2-b888-401e-ba64-539683ca50fd', '3-4 lá lốt', 'á lốt', '3-4 l', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('48e0e3d2-b888-401e-ba64-539683ca50fd', 1, 'Nấu cháo với tỉ lệ 1 thìa gạo và 4 thìa nước trong 1 tiếng là cháo chín', ''),
('48e0e3d2-b888-401e-ba64-539683ca50fd', 2, 'Thịt ếch rửa sạch rồi bằm nhỏ, nấm thái dạng sợi, lá lốt cắt nhỏ', ''),
('48e0e3d2-b888-401e-ba64-539683ca50fd', 3, 'Cho chảo lên bếp phi thơm hành khô rồi cho thịt ếch vào xào chung tiếp đến cho nấm và lá lốt vào đảo cùng', ''),
('48e0e3d2-b888-401e-ba64-539683ca50fd', 4, 'Lá lốt và nấm xay nhuyễn với chút nước rồi đổ vào cháo đun lên', ''),
('48e0e3d2-b888-401e-ba64-539683ca50fd', 5, 'Cháo chín đổ ra thêm thịt ếch lên trên là xong', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('48e0e3d2-b888-401e-ba64-539683ca50fd', 420, 33.0, 31.0, 18.0, 6.5, 25.4, 3.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('48e0e3d2-b888-401e-ba64-539683ca50fd', 'món ngon mỗi ngày'),
('48e0e3d2-b888-401e-ba64-539683ca50fd', 'dễ làm');

-- Món ăn: Cháo thịt ếch 🐸 bí xanh
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('424acda6-06c9-41bd-810b-4ce9d453c7b9', 'Cháo thịt ếch 🐸 bí xanh', '#chao #thitech #bixanh #andam #bepnhacop', 'https://img-global.cpcdn.com/recipes/b6f15f091402439a/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 phần', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/17146508', 'Bếp nhà Cọp')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('424acda6-06c9-41bd-810b-4ce9d453c7b9', '25 g gạo', 'gạo', '25 g', 1),
('424acda6-06c9-41bd-810b-4ce9d453c7b9', '15 g thịt ếch', 'thịt ếch', '15 g', 1),
('424acda6-06c9-41bd-810b-4ce9d453c7b9', '15 g bí xanh', 'bí xanh', '15 g', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('424acda6-06c9-41bd-810b-4ce9d453c7b9', 1, 'Nấu cháo với tỉ lệ 1:4 (là 1 thìa gạo với 4 thìa nước) trong 1 tiếng là cháo chín', ''),
('424acda6-06c9-41bd-810b-4ce9d453c7b9', 2, 'Bí xanh gọt vỏ thái dạng hạt lựu rồi cho vào nồi cháo nấu chung', ''),
('424acda6-06c9-41bd-810b-4ce9d453c7b9', 3, 'Ếch lọc xương làm sạch bằm nhỏ đem xào thơm lên với hành khô', ''),
('424acda6-06c9-41bd-810b-4ce9d453c7b9', 4, 'Cháo chín múc ra bát thêm thịt ếch lên trên là xong', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('424acda6-06c9-41bd-810b-4ce9d453c7b9', 300, 15.0, 31.0, 10.0, 6.5, 74.0, 3.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('424acda6-06c9-41bd-810b-4ce9d453c7b9', 'món ngon mỗi ngày'),
('424acda6-06c9-41bd-810b-4ce9d453c7b9', 'dễ làm');

-- Món ăn: Ếch nướng lá lốt bằng nckd
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('00005c7f-83cb-4033-810f-da6314be6a14', 'Ếch nướng lá lốt bằng nckd', 'Món này mình học của bạn @miecook_181118 rất là thơm luôn. Ct gốc của bạn ấy có sa tế nữa nhưng mình ko cho vì con mình ko ăn cay được, nhưng có sa tế chắc sẽ càng ngon hơn.', 'https://img-global.cpcdn.com/recipes/476d8671749ac2a0/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/17081222', 'Dibee')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('00005c7f-83cb-4033-810f-da6314be6a14', '3 con ếch mặp', 'ếch mặp', '3 con', 1),
('00005c7f-83cb-4033-810f-da6314be6a14', '1 nắm lá lốt', 'lá lốt', '1 nắm', 1),
('00005c7f-83cb-4033-810f-da6314be6a14', 'Tỏi, muối hồng, mirin, nước mắm cho bé', 'tỏi, muối hồng, mirin, nước mắm cho bé', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('00005c7f-83cb-4033-810f-da6314be6a14', 1, 'Ếch làm sạch, cắt thành từng phần cho dễ ướp. Trong một thố giã lá lốt, vài tép tỏi, 1 mcf muối hồng, 1 muỗng canh mirin, 1 mcf nước mắm. Giã nát hỗn hợp, cho thêm 1 muỗng canh dầu ăn + bột hành vào trộn đều. Cho vào ếch ướp ít nhất 30ph', 'https://img-global.cpcdn.com/steps/bbfcd1e7bf4856f7/400x400cq80/photo.jpg'),
('00005c7f-83cb-4033-810f-da6314be6a14', 2, 'Xếp ếch lên vỉ nướng, xịt dầu ăn lên bề mặt. Mình nướng nckd nhiệt 155 độ trong 20 phút. Xong trở mặt và nướng thêm 15 phút nữa. (Nhiệt nckd của mình khá nóng nên mình ko để cao. Tuỳ vào nồi chiên của bạn mà điều chỉnh nhiệt)', 'https://img-global.cpcdn.com/steps/25b2dc2d4d73cfba/400x400cq80/photo.jpg'),
('00005c7f-83cb-4033-810f-da6314be6a14', 3, 'Thành phẩm cực kỳ thơm ngon. Ăn chấm muối tiêu chanh. Nhà mình dứt sạch. 😋', 'https://img-global.cpcdn.com/steps/2febfebf72431ac2/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('00005c7f-83cb-4033-810f-da6314be6a14', 400, 15.0, 25.0, 18.0, 3.0, 23.6, 1.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('00005c7f-83cb-4033-810f-da6314be6a14', 'món ngon mỗi ngày'),
('00005c7f-83cb-4033-810f-da6314be6a14', 'dễ làm');

-- Món ăn: Ếch nướng sa tế lá lốt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('0f94c98d-d0b1-4d04-ac80-8262c0e4699c', 'Ếch nướng sa tế lá lốt', 'Cách làm món Ếch nướng sa tế lá lốt ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/8b687b77e8f78609/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/17064763', 'My Duong')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('0f94c98d-d0b1-4d04-ac80-8262c0e4699c', '1/2 kg ếch (tầm 5-6 con)', 'ếch', '1/2 kg', 1),
('0f94c98d-d0b1-4d04-ac80-8262c0e4699c', 'sa tế, muối ớt, đường, tiêu, nước mắm, lá lốt', 'sa tế, muối ớt, đường, tiêu, nước mắm, lá lốt', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('0f94c98d-d0b1-4d04-ac80-8262c0e4699c', 1, 'Ếch làm sạch, ướp với 2 muỗng sa tế, 1 muỗng muối ớt, 1 muỗng đường, 2 muỗng nước mắm, ít tiêu (tùy khẩu vị có thể thêm hoặc bớt). Để lâu cho thấm gia vị.', ''),
('0f94c98d-d0b1-4d04-ac80-8262c0e4699c', 2, 'Hái 1 nắm lá lốt rửa sạch, cắt nhuyễn ướp vào cùng với gia vị.', ''),
('0f94c98d-d0b1-4d04-ac80-8262c0e4699c', 3, 'Nướng bếp than hoặc nồi chiên không dầu, nướng bếp than sẽ thơm hơn.', ''),
('0f94c98d-d0b1-4d04-ac80-8262c0e4699c', 4, 'Nướng đến khi thịt trắng, trở mặt lần 1 quét lại nước ướp gia vị hoặc dầu ăn, làm tương tự với mặt còn lại. Thịt sẽ không bị khô và lên màu đẹp.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('0f94c98d-d0b1-4d04-ac80-8262c0e4699c', 400, 15.0, 25.0, 18.0, 3.0, 56.4, 3.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('0f94c98d-d0b1-4d04-ac80-8262c0e4699c', 'món ngon mỗi ngày'),
('0f94c98d-d0b1-4d04-ac80-8262c0e4699c', 'dễ làm');

-- Món ăn: Ếch om cà
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 'Ếch om cà', 'Cách làm món Ếch om cà ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/43b4dd3f1c471ee7/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/16973888', 'Nguyễn Thị Duyên')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 'Cà dĩa sọc xanh', 'cà dĩa sọc xanh', 'Tùy lượng', 1),
('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 'Ếch', 'ếch', 'Tùy lượng', 1),
('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 'Lá lốt', 'lá lốt', 'Tùy lượng', 1),
('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 'ớt', 'ớt', 'Tùy lượng', 1),
('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 'nghệ tươi', 'nghệ tươi', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 1, 'Ếch mua ngoài chợ nhờ người ta làm thịt sẵn', ''),
('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 2, 'Cà mua về cắt giống múi cau sau đó ngâm liền vào nước muối pha loãng 5-10p vớt ra để ráo', ''),
('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 3, 'Ếch chặt khúc cho vào nồi ướp giá vị,muối,hạt nêm,bột ngọt.cắt 1 trái ở bỏ vào cho thêm dầu ăn,hành tím băm nhỏ, nghệ đập dập băm nhỏ vào đảo đều ướp 15p.sau đó cho lên bếp đảo qua lại tới khi thịt ếch săn lại thì cho cà vào, cho 2 muỗng canh mẻ tiếp tục đảo đều.(mẻ cho tuỳ khẩu vị gia đình thích ăn chua cho nhiều ăn ít chua cho ít)', ''),
('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 4, 'Đun 1 ấm nước sôi chế vào nồi cà để nước xấp2 với mặt cà và ếch.sau đó đậy nắp đun tới khi nào cà chín trong quá trình đun đảo 1lần tránh đảo nhiều làm cà và ếch nát.khi đã chín thái lá lốt nhỏ cho vào đảo 1 lần nữa tắt bếp mở nắp vung.được như hình trên', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 300, 15.0, 25.0, 10.0, 3.0, 79.2, 3.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('14540fe3-d56e-4bfd-aab0-cacaf54149aa', 'món kho');

-- Món ăn: Ếch chiên bột giòn
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('cbf10bc1-31c5-453a-a79e-453542f0ee7c', 'Ếch chiên bột giòn', 'Cách làm món Ếch chiên bột giòn ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/9244e31991828a29/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/16950072', 'Arany Green')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('cbf10bc1-31c5-453a-a79e-453542f0ee7c', 'Ếch', 'ếch', 'Tùy lượng', 1),
('cbf10bc1-31c5-453a-a79e-453542f0ee7c', 'Bột chiên giòn khô, tẩm sẵn gia vị', 'bột chiên giòn khô, tẩm sẵn gia vị', 'Tùy lượng', 1),
('cbf10bc1-31c5-453a-a79e-453542f0ee7c', 'Dầu ăn', 'dầu ăn', 'Tùy lượng', 1),
('cbf10bc1-31c5-453a-a79e-453542f0ee7c', 'Xà lách', 'xà lách', 'Tùy lượng', 1),
('cbf10bc1-31c5-453a-a79e-453542f0ee7c', 'dưa leo…ăn kèm', 'dưa leo…ăn kèm', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('cbf10bc1-31c5-453a-a79e-453542f0ee7c', 1, 'Ếch làm sạch, cắt làm 2-4 phần. Lăn ếch qua bột chiên giòn (loại khô, có gia vị sẵn)', ''),
('cbf10bc1-31c5-453a-a79e-453542f0ee7c', 2, 'Chiên vàng ếch với dầu nóng, vớt ra để ráo. Ăn nóng giòn chấm với muối tiêu chanh, tương ớt rất ngon ạ', 'https://img-global.cpcdn.com/steps/ef857c5c0aa69372/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('cbf10bc1-31c5-453a-a79e-453542f0ee7c', 400, 15.0, 25.0, 18.0, 3.0, 50.4, 4.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('cbf10bc1-31c5-453a-a79e-453542f0ee7c', 'chiên giòn');

-- Món ăn: Cháo ếch bí đao
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('b8b58dc7-3555-40a9-8819-daed270dd228', 'Cháo ếch bí đao', 'Cách làm món Cháo ếch bí đao ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/d28ddcce0dd3afb4/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/16841718', 'Anhchan Kitchen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('b8b58dc7-3555-40a9-8819-daed270dd228', '2con to ếch', 'to ếch', '2con', 1),
('b8b58dc7-3555-40a9-8819-daed270dd228', 'Bí đao', 'bí đao', 'Tùy lượng', 1),
('b8b58dc7-3555-40a9-8819-daed270dd228', 'Gạo', 'gạo', 'Tùy lượng', 1),
('b8b58dc7-3555-40a9-8819-daed270dd228', 'hành tím', 'hành tím', 'Tùy lượng', 1),
('b8b58dc7-3555-40a9-8819-daed270dd228', 'hành lá', 'hành lá', 'Tùy lượng', 1),
('b8b58dc7-3555-40a9-8819-daed270dd228', 'nước mắm', 'nước mắm', 'Tùy lượng', 1),
('b8b58dc7-3555-40a9-8819-daed270dd228', 'hạt nêm', 'hạt nêm', 'Tùy lượng', 1),
('b8b58dc7-3555-40a9-8819-daed270dd228', 'tiêu', 'tiêu', 'Tùy lượng', 1),
('b8b58dc7-3555-40a9-8819-daed270dd228', 'bột ngọt', 'bột ngọt', 'Tùy lượng', 1),
('b8b58dc7-3555-40a9-8819-daed270dd228', 'muối', 'muối', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('b8b58dc7-3555-40a9-8819-daed270dd228', 1, 'Cho gạo lên nồi nấu cháo. Bí đao gọt vỏ rửa sạch, xay nhuyễn cho vào nấu cùng gạo.', ''),
('b8b58dc7-3555-40a9-8819-daed270dd228', 2, 'Ếch làm sạch, ướp hành tím, nước mắm, hạt nêm, tiêu. ướp khoảng 15 phút thì cho tý dầu ăn lên bếp, dầu nóng thì cho ếch vào xào, đảo cho ếch chín rồi đổ tất cả vào nồi cháo đang nấu rồi tiếp tục nấu, nấu đến khi mềm là được, thêm bột ngọt, muối, nêm nếm lại, thêm hành lá vào vậy là xong', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('b8b58dc7-3555-40a9-8819-daed270dd228', 300, 15.0, 31.0, 10.0, 6.5, 46.1, 4.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('b8b58dc7-3555-40a9-8819-daed270dd228', 'món ngon mỗi ngày'),
('b8b58dc7-3555-40a9-8819-daed270dd228', 'dễ làm');

-- Món ăn: Cháo ếch hạt sen
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 'Cháo ếch hạt sen', 'Cách làm món Cháo ếch hạt sen ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/adb3d39365063e3e/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/16819105', 'Anhchan Kitchen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 'Ếch', 'ếch', 'Tùy lượng', 1),
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 'Hạt sen', 'hạt sen', 'Tùy lượng', 1),
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 'Cà rốt', 'cà rốt', 'Tùy lượng', 1),
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 'hành tím', 'hành tím', 'Tùy lượng', 1),
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 'nước mắm', 'nước mắm', 'Tùy lượng', 1),
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 'hạt nêm', 'hạt nêm', 'Tùy lượng', 1),
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 'bột ngọt', 'bột ngọt', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 1, 'Ếch mua về làm sạch ướp hành tím, nước mắm, hạt nêm.hạt sen rửa sạch, cà rốt cắt hạt lựu.', ''),
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 2, 'Cho cơm nguội vào nồi,thêm nước vào để ninh,cho luôn hạt sen,cà rốt vào ninh nhừ.', ''),
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 3, 'Cho chảo dầu lên bếp, sau đó cho ếch vào xào, ếch chín thì cho ếch vào nồi cháo đang hầm.hầm tiếp cho đến khi tất cả mềm, cho thêm bột ngọt, nêm nếm lại, vậy là xong, cho ra tô thêm hành lá vào và ăn thôi.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 300, 15.0, 31.0, 10.0, 6.5, 20.8, 3.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 'món ngon mỗi ngày'),
('9f2a4821-90b0-4f87-b646-6f00a654e0e7', 'dễ làm');

-- Món ăn: Ếch xào mướp - lá lốt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('68be3a5c-0645-4e4a-8739-4a888a0b319e', 'Ếch xào mướp - lá lốt', 'Món ngon cho bé 8-9m ăn dặm 🤤🤤', 'https://img-global.cpcdn.com/recipes/49159a96ed704503/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/16608614', 'Bếp Mẹ Nị')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('68be3a5c-0645-4e4a-8739-4a888a0b319e', 'Đùi ếch', 'đùi ếch', 'Tùy lượng', 1),
('68be3a5c-0645-4e4a-8739-4a888a0b319e', 'Mướp', 'mướp', 'Tùy lượng', 1),
('68be3a5c-0645-4e4a-8739-4a888a0b319e', 'Lá lốt', 'lá lốt', 'Tùy lượng', 1),
('68be3a5c-0645-4e4a-8739-4a888a0b319e', 'Hành', 'hành', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('68be3a5c-0645-4e4a-8739-4a888a0b319e', 1, 'Cắt nhỏ thịt ếch, mướp và lá lốt.', ''),
('68be3a5c-0645-4e4a-8739-4a888a0b319e', 2, 'Bắt chảo dầu. Dầu nóng phi ít hành tím hoặc đầu hành. Cho ếch vào xào săn, sau đó cho mướp và thêm chút nước.', ''),
('68be3a5c-0645-4e4a-8739-4a888a0b319e', 3, 'Ếch và mướp chín, cho lá lốt vào. Cắt hành lá cho thơm. Có thể nêm xíu muối và tiêu nếu bé trên 1 tuổi.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('68be3a5c-0645-4e4a-8739-4a888a0b319e', 300, 15.0, 31.0, 10.0, 6.5, 54.5, 2.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('68be3a5c-0645-4e4a-8739-4a888a0b319e', 'món xào');

-- Món ăn: Ếch rim nước dừa
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('ddccc660-c887-4176-bf13-d593fe125d69', 'Ếch rim nước dừa', 'Cách làm món Ếch rim nước dừa ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/12e0ecda5cf5b29c/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 em bé', 'Món chính', 'https://cookpad.com/vn/cong-thuc/16576146', 'Phương Văn')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('ddccc660-c887-4176-bf13-d593fe125d69', '1 con Ếch', 'ếch', '1 con', 1),
('ddccc660-c887-4176-bf13-d593fe125d69', '200 ml nước dừa tươi', 'nước dừa tươi', '200 ml', 1),
('ddccc660-c887-4176-bf13-d593fe125d69', '1 muỗng cà phê dầu hào em bé', 'dầu hào em bé', '1 muỗng cà phê', 1),
('ddccc660-c887-4176-bf13-d593fe125d69', '1 ít hành lá', 'hành lá', '1 ít', 1),
('ddccc660-c887-4176-bf13-d593fe125d69', '1 ít tỏi băm', 'tỏi băm', '1 ít', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('ddccc660-c887-4176-bf13-d593fe125d69', 1, 'Làm sạch và sơ chế ếch. Ngâm ếch với muối, rượu và 1 ít gừng để khử tanh. Rửa qua nhiều lần nước, sau đó rửa qua 1 lần nữa với nước sôi và để ráo.', ''),
('ddccc660-c887-4176-bf13-d593fe125d69', 2, 'Cho dầu hoa cải vào chảo, phi thơm tỏi sau đó cho ếch vào đảo sơ để thịt ếch săn lại. Cho nước dừa và 1 muỗng dầu hào em bé vào, vặn bếp lửa nhỏ liu riu cho ếch thấm.', ''),
('ddccc660-c887-4176-bf13-d593fe125d69', 3, 'Tắt bếp nêm thêm hành lá cắt khúc và 1 ít tiêu cho thơm. Cơm trắng trộn với nước sốt của ếch rất ngon, vị thơm và ngọt dịu của nước dừa. Chúc mấy dì thành công nha.', 'https://img-global.cpcdn.com/steps/8bd8490aa24fbcb2/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('ddccc660-c887-4176-bf13-d593fe125d69', 300, 15.0, 25.0, 10.0, 3.0, 35.4, 2.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('ddccc660-c887-4176-bf13-d593fe125d69', 'món ngon mỗi ngày'),
('ddccc660-c887-4176-bf13-d593fe125d69', 'dễ làm');

-- Món ăn: Ếch chiên xào bơ hành sả
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('545114ed-d226-486c-aaf8-1b0ad48aff31', 'Ếch chiên xào bơ hành sả', 'Ké được công thức của 1 mom trên cookpad và tự chế lại 😂😂😂', 'https://img-global.cpcdn.com/recipes/4b176f0304dbf062/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 phần ăn', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/16523413', 'Tuyết Nhi Phạm')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('545114ed-d226-486c-aaf8-1b0ad48aff31', '2 đùi ếch', 'đùi ếch', '2', 1),
('545114ed-d226-486c-aaf8-1b0ad48aff31', '2 thìa bột mỳ', 'bột mỳ', '2 thìa', 1),
('545114ed-d226-486c-aaf8-1b0ad48aff31', '1 nhánh sả', 'sả', '1 nhánh', 1),
('545114ed-d226-486c-aaf8-1b0ad48aff31', '2 cây hành lá', 'hành lá', '2 cây', 1),
('545114ed-d226-486c-aaf8-1b0ad48aff31', '1 thìa bơ meizan hoặc tường an', 'bơ meizan hoặc tường an', '1 thìa', 1),
('545114ed-d226-486c-aaf8-1b0ad48aff31', '1/3 muỗng cà phê muối hồng', 'muối hồng', '1/3 muỗng cà phê', 1),
('545114ed-d226-486c-aaf8-1b0ad48aff31', '1/3 muỗng cà phê nước mắm', 'nước mắm', '1/3 muỗng cà phê', 1),
('545114ed-d226-486c-aaf8-1b0ad48aff31', '1/2 muỗng cà phê hạt nêm', 'hạt nêm', '1/2 muỗng cà phê', 1),
('545114ed-d226-486c-aaf8-1b0ad48aff31', '1/2 muỗng cà phê hạt nêm', 'hạt nêm', '1/2 muỗng cà phê', 1),
('545114ed-d226-486c-aaf8-1b0ad48aff31', '1/4 muỗng cà phê tiêu xay', 'tiêu xay', '1/4 muỗng cà phê', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('545114ed-d226-486c-aaf8-1b0ad48aff31', 1, 'Làm sạch ếch, rửa nước muối sạch sẽ. Sau đó ướp ếch với muối hồng + tiêu.', ''),
('545114ed-d226-486c-aaf8-1b0ad48aff31', 2, 'Cắt nhỏ hành lá và băm nhuyễn sả. Đun chảy 1 muỗng bơ và cho vào bát riêng. Bột mỳ cho 1 bát riêng.', ''),
('545114ed-d226-486c-aaf8-1b0ad48aff31', 3, 'Tiếp đó cho vào chảo 1 muỗng dầu ăn cho bé chờ dầu nóng thì : lăn đùi ếch qua bơ đã đun chảy tiếp đó phủ thêm 1 lớp bột mỳ rồi bỏ vào chiên ở lửa nhỏ.', ''),
('545114ed-d226-486c-aaf8-1b0ad48aff31', 4, 'Chờ đùi ếch chiên hơi vàng thì bỏ sả và hành lá vào xào tiếp. Nêm nước mắm + hạt nêm vào xào thêm 1 lát cho thấm gia vị thì tắt bếp.', ''),
('545114ed-d226-486c-aaf8-1b0ad48aff31', 5, 'Trình bày cho đẹp mắt và cho con măm măm thôi ạ 😂😂😂 mình cho con ăn kèm cơm nát đậu xanh trộn rong biển. 😋😋😋', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('545114ed-d226-486c-aaf8-1b0ad48aff31', 400, 15.0, 25.0, 18.0, 3.0, 43.4, 4.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('545114ed-d226-486c-aaf8-1b0ad48aff31', 'món xào'),
('545114ed-d226-486c-aaf8-1b0ad48aff31', 'chiên giòn');

-- Món ăn: Cháo ếch đậu xanh cho bé
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('44be81cc-66b6-4fc7-95c0-c1063dc01063', 'Cháo ếch đậu xanh cho bé', 'Thay đổi món cho 1 em bé lười ăn ham chơi và đang trong giai đoạn khủng hoảng tuổi lên 2 🥲 Bữa sáng cho con !', 'https://img-global.cpcdn.com/recipes/cc7025b0daad7a8a/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 phần ăn', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/16523418', 'Tuyết Nhi Phạm')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('44be81cc-66b6-4fc7-95c0-c1063dc01063', '1 con ếch', 'ếch', '1 con', 1),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', '5 cây hành lá', 'hành lá', '5 cây', 1),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', '2 thìa đậu xanh', 'đậu xanh', '2 thìa', 1),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', '5 thìa gạo', 'gạo', '5 thìa', 1),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', 'Muối hồng', 'muối hồng', 'Tùy lượng', 1),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', 'nước mắm', 'nước mắm', 'Tùy lượng', 1),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', 'hạt nêm', 'hạt nêm', 'Tùy lượng', 1),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', 'tiêu', 'tiêu', 'Tùy lượng', 1),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', '2 củ nén', 'nén', '2 củ', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('44be81cc-66b6-4fc7-95c0-c1063dc01063', 1, 'Nấu cháo và đậu xanh. Ếch luộc chín lóc xương và xay nhuyễn thịt', ''),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', 2, 'Bóc vỏ đập dập 2 củ nén, phi thơm cùng dầu ăn và bỏ ếch vào xào. Tiếp đó cho thêm ít nước nóng vào chờ sôi thì cho cháo đậu xanh đã chín vào.', ''),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', 3, 'Nêm nước mắm và hạt nêm cho bé. Tắt bếp rắc ít tiêu và trộn đều. Cho ra bát để con măm măm thôi ạ. Bữa sáng nhanh gọn lẹ để con đi học cho kịp và mẹ chạy đi làm 😆', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('44be81cc-66b6-4fc7-95c0-c1063dc01063', 300, 15.0, 25.0, 10.0, 3.0, 76.4, 2.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('44be81cc-66b6-4fc7-95c0-c1063dc01063', 'món ngon mỗi ngày'),
('44be81cc-66b6-4fc7-95c0-c1063dc01063', 'dễ làm');

-- Món ăn: Ếch xào sả không ớt ;)
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('1681f663-a83e-4c92-9bb5-dc24f7688b60', 'Ếch xào sả không ớt ;)', 'Bạn nhỏ mê món này nhưng không ăn cay được nên mình không bỏ ớt trong này nhé', 'https://img-global.cpcdn.com/recipes/736d45add6ccdad3/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 lớn 1 nhỏ', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/16430523', 'Thaophuong Phạm')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('1681f663-a83e-4c92-9bb5-dc24f7688b60', '500 gr đùi ếch làm sạch', 'r đùi ếch làm sạch', '500 g', 1),
('1681f663-a83e-4c92-9bb5-dc24f7688b60', 'Bột nghệ', 'bột nghệ', 'Tùy lượng', 1),
('1681f663-a83e-4c92-9bb5-dc24f7688b60', 'Cari dầu', 'cari dầu', 'Tùy lượng', 1),
('1681f663-a83e-4c92-9bb5-dc24f7688b60', 'Sả băm', 'sả băm', 'Tùy lượng', 1),
('1681f663-a83e-4c92-9bb5-dc24f7688b60', '2 muỗng canh Nước mắm', 'nước mắm', '2 muỗng canh', 1),
('1681f663-a83e-4c92-9bb5-dc24f7688b60', '2 mcf hạt nêm', 'mcf hạt nêm', '2', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('1681f663-a83e-4c92-9bb5-dc24f7688b60', 1, 'Ếch rửa sạch, ướp 15ph với sả băm, bột nghệ, cari dầu, 2 muỗng nước mắm, 2 mcf hạt nêm', 'https://img-global.cpcdn.com/steps/3359f89aaabc93f8/400x400cq80/photo.jpg'),
('1681f663-a83e-4c92-9bb5-dc24f7688b60', 2, 'Cho ít dầu ăn vào chảo đun sôi dầu ròi xếp mấy em chân dài vào. Mình nấu bằng bếp từ nên để chế độ stir lửa nhỏ cho ếch chín đều mà không bị khét sả, đảo nhẹ tay cho khỏi rụng chân cẳng, tới khi thịt chín vàng đều, nước hơi sánh lại là được', 'https://img-global.cpcdn.com/steps/45989e7f950d69a4/400x400cq80/photo.jpg'),
('1681f663-a83e-4c92-9bb5-dc24f7688b60', 3, 'Chín vàng đẹp ròi múc ra dĩa thôi. Nếu ăn cay thêm ớt bằm vào từ khâu ướp, sẽ ngon hơn nhiều nhiều :)', 'https://img-global.cpcdn.com/steps/674bd94fa23b7b69/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('1681f663-a83e-4c92-9bb5-dc24f7688b60', 300, 15.0, 25.0, 10.0, 3.0, 64.1, 3.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('1681f663-a83e-4c92-9bb5-dc24f7688b60', 'món xào');

-- Món ăn: Ếch xào sả
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('d21d2279-829c-48f6-9356-281ed7e37f5a', 'Ếch xào sả', 'Từ nay về Việt Nam rồi nên ở Việt Nam có nhiều nguyên liệu để mình luyện tay nghề thôi.', 'https://img-global.cpcdn.com/recipes/28d31f0b84bbb75b/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/16385266', 'Anhchan Kitchen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('d21d2279-829c-48f6-9356-281ed7e37f5a', 'Ếch', 'ếch', 'Tùy lượng', 1),
('d21d2279-829c-48f6-9356-281ed7e37f5a', 'Sả', 'sả', 'Tùy lượng', 1),
('d21d2279-829c-48f6-9356-281ed7e37f5a', 'Ớt', 'ớt', 'Tùy lượng', 1),
('d21d2279-829c-48f6-9356-281ed7e37f5a', 'Hành tây', 'hành tây', 'Tùy lượng', 1),
('d21d2279-829c-48f6-9356-281ed7e37f5a', 'Tỏi', 'tỏi', 'Tùy lượng', 1),
('d21d2279-829c-48f6-9356-281ed7e37f5a', 'Hành tím', 'hành tím', 'Tùy lượng', 1),
('d21d2279-829c-48f6-9356-281ed7e37f5a', 'Gia vị', 'gia vị', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('d21d2279-829c-48f6-9356-281ed7e37f5a', 1, 'Ếch làm sạch,băm tỏi, hành tím,ớt trái cho vào ướp, thêm nước mắm,hạt nêm,hạt tiêu, muối cho vào ướp.', ''),
('d21d2279-829c-48f6-9356-281ed7e37f5a', 2, 'Sả 1 ít băm nhỏ,1 ít thái lát, sả băm nhỏ thì cho vào ướp cùng với ếch còn sả thái lát thì để lát nữa xào.hành tây thái sợi hoặc thái múi cau nhỏ vừa ăn', ''),
('d21d2279-829c-48f6-9356-281ed7e37f5a', 3, 'Cho sả thái lát vào chảo,bật bếp lên đảo đều 1 lúc sau đó cho ít dầu ăn vào rồi cho ếch đã ướp vào,đảo 1lúc nữa sau đó cho nước vào để cho sôi,cho thấm gia vị, rồi cho hành tây, ít đường và bột ngọt vào đảo đều rồi để cho khô nước.cho thêm 1 ít màu điều vào chỗ có màu nếu muốn.đến lúc khô không còn nước nữa thì cho hành lá vào nêm nếm lại vậy là xong rồi.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('d21d2279-829c-48f6-9356-281ed7e37f5a', 300, 15.0, 25.0, 10.0, 3.0, 25.9, 1.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('d21d2279-829c-48f6-9356-281ed7e37f5a', 'món xào');

-- Món ăn: MÓN SINGAPORE: CHÁO ẾCH SINGAPORE 🇸🇬
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('026d8c04-9372-489f-ab95-656dc0344c66', 'MÓN SINGAPORE: CHÁO ẾCH SINGAPORE 🇸🇬', '#Daisucookpad2022 #bepcomnha #seagames31 1 trong những món ăn đặc trưng của đất nước Singapore và quen thuộc với khẩu vị của người Việt với cách làm khá đơn giản', 'https://img-global.cpcdn.com/recipes/237efad43a2992b0/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/16246136', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('026d8c04-9372-489f-ab95-656dc0344c66', '500 g thịt ếch', 'thịt ếch', '500 g', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', '1 lon gạo', 'on gạo', '1 l', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', '3 trái ớt khô', 'ớt khô', '3 trái', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', '2 cây hành lá', 'hành lá', '2 cây', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', '1 củ tỏi', 'tỏi', '1 củ', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', 'Rượu trắng', 'rượu trắng', 'Tùy lượng', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', 'Giấm gạo', 'giấm gạo', 'Tùy lượng', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', 'Dầu ăn', 'dầu ăn', 'Tùy lượng', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', 'Dầu hào', 'dầu hào', 'Tùy lượng', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', 'Hắc xì dầu', 'hắc xì dầu', 'Tùy lượng', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', 'Hạt nêm', 'hạt nêm', 'Tùy lượng', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', 'Muối', 'muối', 'Tùy lượng', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', 'Đường', 'đường', 'Tùy lượng', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', 'Tiêu xay', 'tiêu xay', 'Tùy lượng', 1),
('026d8c04-9372-489f-ab95-656dc0344c66', 'Dầu mè', 'dầu mè', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('026d8c04-9372-489f-ab95-656dc0344c66', 1, 'Hành lá bỏ gốc, rửa sạch, cắt nhỏ, đầu hành băm nhỏ. Tỏi bỏ vỏ, băm nhỏ. Ếch rửa sạch, ướp với tỏi băm, đầu hành lá băm, ớt khô, 1mc rượu, 1mcf hạt nêm, trộn đều ướp 30 phút. Vo gạo và cho vào nồi nấu cháo cùng 500ml nước và 1/3mcf muối', ''),
('026d8c04-9372-489f-ab95-656dc0344c66', 2, 'Phi thơm tỏi, cho ếch vào đảo săn thì cho thêm 1 chén nước lọc, 1mc dầu hào, 1mc hắc xì dầu, 1mc giấm gạo, 1mc đường, đảo đều cho ếch thấm gia vị và đợi đến khi nước rút bớt thì tắt bếp', 'https://img-global.cpcdn.com/steps/2ede4864a4b41829/400x400cq80/photo.jpg'),
('026d8c04-9372-489f-ab95-656dc0344c66', 3, 'Múc cháo ra tô, thêm chút dầu mè, tiêu xay, hành lá lên trên. Tiếp đến múc ếch ra dĩa hoặc thố để dùng kèm. Món này dùng nóng rất ngon', 'https://img-global.cpcdn.com/steps/fa25802600b4450b/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('026d8c04-9372-489f-ab95-656dc0344c66', 300, 15.0, 25.0, 10.0, 3.0, 28.3, 3.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('026d8c04-9372-489f-ab95-656dc0344c66', 'món ngon mỗi ngày'),
('026d8c04-9372-489f-ab95-656dc0344c66', 'dễ làm');

-- Món ăn: Ếch sốt bơ tỏi
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('28b9fbc4-acc9-4129-b59e-baab9cdc1cf7', 'Ếch sốt bơ tỏi', 'Cách làm món Ếch sốt bơ tỏi ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/238c0abe199ac37c/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/16155372', 'Ching Ching')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('28b9fbc4-acc9-4129-b59e-baab9cdc1cf7', '1 con ếch', 'ếch', '1 con', 1),
('28b9fbc4-acc9-4129-b59e-baab9cdc1cf7', 'Gia vị ướp: mắm, dầu hào, mật ong, tỏi băm', 'gia vị ướp', 'mắm, dầu hào, mật ong, tỏi băm', 1),
('28b9fbc4-acc9-4129-b59e-baab9cdc1cf7', 'Bơ', 'bơ', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('28b9fbc4-acc9-4129-b59e-baab9cdc1cf7', 1, 'Ướp ếch với gia vị 15''', ''),
('28b9fbc4-acc9-4129-b59e-baab9cdc1cf7', 2, 'Đun bơ chảy rồi cho ếch vào xào săn. Cho chút nước vào sốt và rim ếch trong vòng 15''', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('28b9fbc4-acc9-4129-b59e-baab9cdc1cf7', 400, 15.0, 25.0, 18.0, 3.0, 39.2, 3.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('28b9fbc4-acc9-4129-b59e-baab9cdc1cf7', 'món ngon mỗi ngày'),
('28b9fbc4-acc9-4129-b59e-baab9cdc1cf7', 'dễ làm');

-- Món ăn: Ếch nấu hoa chuối
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 'Ếch nấu hoa chuối', 'Cách làm món Ếch nấu hoa chuối ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/f5d7f0a3a3f69a5d/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/16118855', 'Pham Diep')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 'Hoa chuối', 'hoa chuối', 'Tùy lượng', 1),
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 'Ếch', 'ếch', 'Tùy lượng', 1),
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 'Cà chua', 'cà chua', 'Tùy lượng', 1),
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 'Mẻ', 'mẻ', 'Tùy lượng', 1),
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 'Hành tỏi', 'hành tỏi', 'Tùy lượng', 1),
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 'nước mắm, muối, hạt nêm', 'nước mắm, muối, hạt nêm', 'Tùy lượng', 1),
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 'hành lá', 'hành lá', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 1, 'Ếch làm sạch rồi mang ướp cùng hành tỏi, hạt nêm và chút dầu hào Thái hoa chuối nhỏ rồi ngâm vào nước để chuối không bị thâm', ''),
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 2, 'Phi thơm hành tỏi rồi cho ếch vào đảo cho săn, sau đó thêm chút nước mắm và cà chua vào đảo thêm rồi cho nước vào nấu chín ếch Ếch chín thì cho rau hoa chuối vào thêm cơm mẻ và bột nghệ cùng muối và hạt nêm', ''),
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 3, 'Nấu chín hoa chuối rồi nêm lại, thêm hành lá rồi bắc xuống', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 300, 15.0, 25.0, 10.0, 3.0, 42.9, 3.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 'món ngon mỗi ngày'),
('636ba840-2622-49d0-b3fb-b2f5ee4f2175', 'dễ làm');

-- Món ăn: Mì quảng ếch
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 'Mì quảng ếch', 'Nay e hứng lên nên e nấu mì quảng ếch thôi :))) Công thức đơn giản nên dễ làm lắm nha quý zdị 😁 Mình nấu cho tập thể nên các bạn khi nấu thì giảm hết nguyên liệu, gia vị xuống 1 nửa nha', 'https://img-global.cpcdn.com/recipes/d63a3cbbb97d0480/1200x630cq80/photo.jpg', 30, 'Trung bình', '10 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/16096403', 'Huy Đẹp Trai')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 'Ếch (mình mua 2kg)', 'ếch', 'Tùy lượng', 1),
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', '3,5 kg Mì quảng', 'mì quảng', '3,5 kg', 1),
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 'Rau sống', 'rau sống', 'Tùy lượng', 1),
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 'Bánh tráng (bánh đa), đậu phộng', 'bánh tráng , đậu phộng', 'Tùy lượng', 1),
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 'Nén, xả, hành tím, tỏi, nghệ (tất cả đều xay ra nha)', 'nén, xả, hành tím, tỏi, nghệ', 'Tùy lượng', 1),
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 'Dầu hào, nước mắm, đường, muối, đường phèn', 'dầu hào, nước mắm, đường, muối, đường phèn', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 1, 'Ếch các bạn mua về chặt nhỏ ra nha, rửa sạch với nước muối rồi để ráo nước nhá', 'https://img-global.cpcdn.com/steps/a9def3b0998677a6/400x400cq80/photo.jpg'),
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 2, 'Các bạn cho dầu ăn vào khử sơ nén, hành, xả, tỏi, nghệ, ớt (mình thích ăn cay nên cho ớt vào nha, các bạn k cần cho ớt vào cũng đc). Khử xong các bạn cho ếch vào nồi (thau), cho hết nguyên chảo gia vị mình khử vào. Nêm 3 muỗng dầu hào, 4 muỗng nước mắm, 2 muỗng muối, 4 muỗng đường, 1 muỗng tiêu vào trộn đều, ướp 15 phút nhé. Các bạn nấu ít thì giảm gia vị xuống 1 nửa nha', 'https://img-global.cpcdn.com/steps/ab06650c5653aa95/400x400cq80/photo.jpg'),
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 3, 'Ướp xong các bạn cho ếch vào xào sơ cho tái tái (mình quên chụp hình). Tranh thủ bắt giùm mình 1 ấm nước sôi nhe Xào sơ xong thì các bạn cho ếch vào nồi, cho nước sôi vào (các bạn ăn chừng nào thì tự ước lượng nước nha)', 'https://img-global.cpcdn.com/steps/cd13f33865782a59/400x400cq80/photo.jpg'),
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 4, 'Đợi nồi nước dùng sôi thì hớt bọt ra nghenn. Nêm 1 cục đường phèn (to thì 1 cục, nhỏ thì 2 cục), 2 muỗng nước mắm, 1 muỗng muối. Mình ăn mặn nên nêm hơi măn he, các bạn tự nêm theo khẩu vị từng người nhá 😁', 'https://img-global.cpcdn.com/steps/64c8980e67dafb48/400x400cq80/photo.jpg'),
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 5, 'Các bạn có thể để dành 1 ít củ nén, giã ra rồi khử để trộn với mì trước khi ăn (bao ngon), rắc đậu phộng, hành lá, bánh tráng lên nữa là OK luônggg Zdị là xong gồi đó, chúc các bạn ngon miệng nhe.', 'https://img-global.cpcdn.com/steps/2851129d9a57220e/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 520, 15.0, 61.0, 18.0, 6.5, 49.7, 4.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 'món ngon mỗi ngày'),
('e9b9b1a8-efc9-473a-b8c0-7cbd22639d56', 'dễ làm');

-- Món ăn: Cà ri ếch cho bé
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('90448349-3f08-487e-9e35-a5ed1490cb85', 'Cà ri ếch cho bé', 'Cách làm món Cà ri ếch cho bé ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/cd49d9c7b152e07a/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/16041322', 'Ching Ching')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('90448349-3f08-487e-9e35-a5ed1490cb85', '1 con ếch', 'ếch', '1 con', 1),
('90448349-3f08-487e-9e35-a5ed1490cb85', '1/2 củ Khoai lang', 'khoai lang', '1/2 củ', 1),
('90448349-3f08-487e-9e35-a5ed1490cb85', 'Bột hành, bột tỏi, bột nghệ, bột cà ri', 'bột hành, bột tỏi, bột nghệ, bột cà ri', 'Tùy lượng', 1),
('90448349-3f08-487e-9e35-a5ed1490cb85', 'Hành tím, hạt nêm em bé', 'hành tím, hạt nêm em bé', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('90448349-3f08-487e-9e35-a5ed1490cb85', 1, 'Làm sạch ếch. Ướp ếch với các loại bột cùng với hạt nêm trong 10''', ''),
('90448349-3f08-487e-9e35-a5ed1490cb85', 2, 'Phi thơm hành tím. Cho khoai lang và ếch vào xào săn. Thêm tí nước sâm sấp ninh lửa nhỏ đến khi nước sệt lại thì tắt bếp', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('90448349-3f08-487e-9e35-a5ed1490cb85', 420, 15.0, 55.0, 10.0, 3.0, 36.5, 1.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('90448349-3f08-487e-9e35-a5ed1490cb85', 'món ngon mỗi ngày'),
('90448349-3f08-487e-9e35-a5ed1490cb85', 'dễ làm');

-- Món ăn: Cháo ếch singapore em bé
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('224fdc5b-f86c-48c5-872c-e991911f460e', 'Cháo ếch singapore em bé', 'Cách làm món Cháo ếch singapore em bé ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/3c290c4678bc9434/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/16029527', 'Ching Ching')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('224fdc5b-f86c-48c5-872c-e991911f460e', '1 con ếch', 'ếch', '1 con', 1),
('224fdc5b-f86c-48c5-872c-e991911f460e', 'Gừng', 'gừng', 'Tùy lượng', 1),
('224fdc5b-f86c-48c5-872c-e991911f460e', 'Đầu hành lá', 'đầu hành lá', 'Tùy lượng', 1),
('224fdc5b-f86c-48c5-872c-e991911f460e', '1 múi cau hành tây', 'múi cau hành tây', '1', 1),
('224fdc5b-f86c-48c5-872c-e991911f460e', '1/2 mcf dầu mè', 'mcf dầu mè', '1/2', 1),
('224fdc5b-f86c-48c5-872c-e991911f460e', '1 mcf dầu hào', 'mcf dầu hào', '1', 1),
('224fdc5b-f86c-48c5-872c-e991911f460e', '1 mcf nước tương tách muối', 'mcf nước tương tách muối', '1', 1),
('224fdc5b-f86c-48c5-872c-e991911f460e', '1 mcf đường thốt nốt hoặc nước ép lê, nước dừa', 'mcf đường thốt nốt hoặc nước ép lê, nước dừa', '1', 1),
('224fdc5b-f86c-48c5-872c-e991911f460e', '1 mcf bột bắp', 'mcf bột bắp', '1', 1),
('224fdc5b-f86c-48c5-872c-e991911f460e', 'Nước lọc', 'nước lọc', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('224fdc5b-f86c-48c5-872c-e991911f460e', 1, 'Ướp thịt ếch với dầu hào, nước tương, dầu mè và gừng trong 30''', ''),
('224fdc5b-f86c-48c5-872c-e991911f460e', 2, 'Đun nóng dầu ăn cho hành tây vào xào rồi cho ếch vào, thêm nước lọc và đường đun khoảng 5-7'' cho ếch chín thì cho đầu hành vào', ''),
('224fdc5b-f86c-48c5-872c-e991911f460e', 3, 'Cho nước bột bắp vào nồi ếch đang nấu. Rắc ít mè lên cho thơm', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('224fdc5b-f86c-48c5-872c-e991911f460e', 300, 15.0, 25.0, 10.0, 3.0, 34.4, 4.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('224fdc5b-f86c-48c5-872c-e991911f460e', 'món ngon mỗi ngày'),
('224fdc5b-f86c-48c5-872c-e991911f460e', 'dễ làm');

-- Món ăn: Ếch sốt teriyaki
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('81a0f950-1a1b-460c-a189-b92d331027dc', 'Ếch sốt teriyaki', 'Cách làm món Ếch sốt teriyaki ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/4f085056b15f3b90/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/15731164', 'Ching Ching')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('81a0f950-1a1b-460c-a189-b92d331027dc', '3 mcf sốt teriyaki', 'mcf sốt teriyaki', '3', 1),
('81a0f950-1a1b-460c-a189-b92d331027dc', '1 mcf đường thốt nốt', 'mcf đường thốt nốt', '1', 1),
('81a0f950-1a1b-460c-a189-b92d331027dc', '1 mcf mè trắng', 'mcf mè trắng', '1', 1),
('81a0f950-1a1b-460c-a189-b92d331027dc', '1 mcf dầu mè', 'mcf dầu mè', '1', 1),
('81a0f950-1a1b-460c-a189-b92d331027dc', 'Hành, tỏi băm', 'hành, tỏi băm', 'Tùy lượng', 1),
('81a0f950-1a1b-460c-a189-b92d331027dc', '1 con ếch', 'ếch', '1 con', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('81a0f950-1a1b-460c-a189-b92d331027dc', 1, 'Ếch làm sạch rửa với muối', ''),
('81a0f950-1a1b-460c-a189-b92d331027dc', 2, 'Trộn tất cả gia vị để làm nước sốt', ''),
('81a0f950-1a1b-460c-a189-b92d331027dc', 3, 'Phi thơm hành, tỏi. Cho ếch vào xào xăn đổ hỗn hợp nước sốt vào thêm xíu nước để tráng chén nước sốt. Rim lửa nhỏ trở mặt ếch để thịt được thấm. Sốt hơi cạn, thịt chín thì tắt bếp', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('81a0f950-1a1b-460c-a189-b92d331027dc', 300, 15.0, 25.0, 10.0, 3.0, 45.6, 1.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('81a0f950-1a1b-460c-a189-b92d331027dc', 'món ngon mỗi ngày'),
('81a0f950-1a1b-460c-a189-b92d331027dc', 'dễ làm');

-- Món ăn: Chả ếch lá lốt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('dd715b28-3e23-4252-bf57-5ca7efceead9', 'Chả ếch lá lốt', 'Cách làm món Chả ếch lá lốt ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/c4d4f5f6148a8204/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/15652951', 'Ching Ching')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('dd715b28-3e23-4252-bf57-5ca7efceead9', '1 con ếch', 'ếch', '1 con', 1),
('dd715b28-3e23-4252-bf57-5ca7efceead9', '1 ít thịt heo', 'thịt heo', '1 ít', 1),
('dd715b28-3e23-4252-bf57-5ca7efceead9', 'Lá lốt', 'lá lốt', 'Tùy lượng', 1),
('dd715b28-3e23-4252-bf57-5ca7efceead9', 'Hành lá', 'hành lá', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('dd715b28-3e23-4252-bf57-5ca7efceead9', 1, 'Ếch làm sạch lọc lấy thịt. Thịt heo, hành lá, lá lốt cắt nhỏ. Đem đi xay càng nhuyễn càng tốt', ''),
('dd715b28-3e23-4252-bf57-5ca7efceead9', 2, 'Nặn tạo hình rồi mang đi chiên vàng đều hai mặt', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('dd715b28-3e23-4252-bf57-5ca7efceead9', 480, 30.0, 25.0, 24.0, 3.0, 31.8, 1.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('dd715b28-3e23-4252-bf57-5ca7efceead9', 'món ngon mỗi ngày'),
('dd715b28-3e23-4252-bf57-5ca7efceead9', 'dễ làm');

-- Món ăn: Ếch nướng lá lốt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('5da28f9d-4e45-43ed-b994-b42f2a38ccd2', 'Ếch nướng lá lốt', '#bepvang', 'https://img-global.cpcdn.com/recipes/b6230a39b99a7e91/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/15606696', 'Moon Yang ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('5da28f9d-4e45-43ed-b994-b42f2a38ccd2', 'Thịt ếch làm sạch', 'thịt ếch làm sạch', 'Tùy lượng', 1),
('5da28f9d-4e45-43ed-b994-b42f2a38ccd2', 'Hành củ khô, hạt tiêu, nước mắm ngon, dầu ăn, bột nêm', 'hành củ khô, hạt tiêu, nước mắm ngon, dầu ăn, bột nêm', 'Tùy lượng', 1),
('5da28f9d-4e45-43ed-b994-b42f2a38ccd2', 'Lá lốt đã làm sạch', 'lá lốt đã làm sạch', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('5da28f9d-4e45-43ed-b994-b42f2a38ccd2', 1, 'Thịt ếch đã làm sạch, cắt miếng vừa ăn, trộn với hành khô bằm, bột hành khô, tiêu bột và một xíu bột mì để hút nước và tạo độ dính trên miếng thịt', 'https://img-global.cpcdn.com/steps/b63c790b95147a4e/400x400cq80/photo.jpg'),
('5da28f9d-4e45-43ed-b994-b42f2a38ccd2', 2, 'Lá lốt thái nhỏ bằm nhuyễn, thêm 1 quả trứng gà vào trộn đều, trứng làm cho thịt không bị khô và tăng độ thơm ngon cho thịt khi nướng', 'https://img-global.cpcdn.com/steps/e3c4a7f9d819fc61/400x400cq80/photo.jpg'),
('5da28f9d-4e45-43ed-b994-b42f2a38ccd2', 3, 'Thêm một chút bột mì vào để tăng thêm độ dính bám của lá lốt, sau đó thêm dầu ăn vào cuối cùng và xếp vào lò chiên không dầu ở 180 độ trong 10p, hoặc cho vào chảo chiên vàng', 'https://img-global.cpcdn.com/steps/b4c7de316f84fe9f/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('5da28f9d-4e45-43ed-b994-b42f2a38ccd2', 400, 15.0, 25.0, 18.0, 3.0, 67.4, 3.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('5da28f9d-4e45-43ed-b994-b42f2a38ccd2', 'món ngon mỗi ngày'),
('5da28f9d-4e45-43ed-b994-b42f2a38ccd2', 'dễ làm');

-- Món ăn: Ếch núp lùm 🥰🥰🥰🥰🥰
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 'Ếch núp lùm 🥰🥰🥰🥰🥰', 'Cách làm món Ếch núp lùm 🥰🥰🥰🥰🥰 ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/2de5895f8f52ed37/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/15595945', 'Trần Liễu')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', '1,5 kí ếch', 'kí ếch', '1,5', 1),
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', '50 g bột mì', 'bột mì', '50 g', 1),
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 'Muối, tiêu, bột ngọt, nước mắm', 'muối, tiêu, bột ngọt, nước mắm', 'Tùy lượng', 1),
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 'Củ tỏi băm nhỏ', 'củ tỏi băm nhỏ', 'Tùy lượng', 1),
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 'củ hành tím băm nhỏ', 'củ hành tím băm nhỏ', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 1, 'Ếch làm sạch chặt ra vừa ăn. Ướp với muối, bột ngọt, nước mắm, tiêu, bột mì.', 'https://img-global.cpcdn.com/steps/67886667043ae464/400x400cq80/photo.jpg'),
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 2, 'Chiên ếch trong ngập dầu với lửa lớn cho giòn', ''),
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 3, 'Sả đập dập dùng nĩa cào cho ra sợi và chiên ngập dầu vớt ra đĩa có lót khăn giấy cho thấm dầu', 'https://img-global.cpcdn.com/steps/3228678df4ef769a/400x400cq80/photo.jpg'),
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 4, 'Vớt ra đĩa và dùng thôi', 'https://img-global.cpcdn.com/steps/67c711a65e5d2146/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 420, 15.0, 55.0, 10.0, 3.0, 69.5, 1.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 'món ngon mỗi ngày'),
('52cf0df5-7812-4f5f-8de3-3cfb0d4cadef', 'dễ làm');

-- Món ăn: Ếch áp chảo nước mắm + nấm xào
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('fb6e77d7-3077-4ba7-a5d1-cd89c1ff1207', 'Ếch áp chảo nước mắm + nấm xào', 'Ếch cũng là thịt trắng nên mọi người có thể ăn để giảm cân nhé ❤️', 'https://img-global.cpcdn.com/recipes/4a3e8daafb363c99/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/15595733', 'Minnie Đỗ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('fb6e77d7-3077-4ba7-a5d1-cd89c1ff1207', '1 con ếch khoảng 200g', 'ếch khoảng 200g', '1 con', 1),
('fb6e77d7-3077-4ba7-a5d1-cd89c1ff1207', 'Nấm', 'nấm', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('fb6e77d7-3077-4ba7-a5d1-cd89c1ff1207', 1, 'Ếch cắt miếng vừa ăn. Ướp cùng 1 ít hạt nêm + ớt + hành khô + nước mắm', ''),
('fb6e77d7-3077-4ba7-a5d1-cd89c1ff1207', 2, 'Nấm xào cùng dầu hào + ớt', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('fb6e77d7-3077-4ba7-a5d1-cd89c1ff1207', 300, 15.0, 31.0, 10.0, 6.5, 36.1, 3.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('fb6e77d7-3077-4ba7-a5d1-cd89c1ff1207', 'món xào');

-- Món ăn: Ếch Sốt Teriyaki (Bé 12m+)
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('ee15760f-fabb-4f1f-8300-5dd2dc991443', 'Ếch Sốt Teriyaki (Bé 12m+)', 'Sốt Teriyaki rất hợp với ếch, lươn, tôm, gà... các mẹ ạ! Mỗi lần mình làm các loại đạm với sốt teri em bé nhà mình tvia ăn rất ngon miệng. Các mẹ thử cho bé nhà mình nhen 😘', 'https://img-global.cpcdn.com/recipes/44cbd6a3392d0bd3/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/15591254', 'Phương Võ (Mẹ Măng) ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('ee15760f-fabb-4f1f-8300-5dd2dc991443', '3 muỗng cf sốt Teriyaki hữu cơ', 'cf sốt teriyaki hữu cơ', '3 muỗng', 1),
('ee15760f-fabb-4f1f-8300-5dd2dc991443', '1 muỗng cf syrup thốt nốt', 'cf syrup thốt nốt', '1 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('ee15760f-fabb-4f1f-8300-5dd2dc991443', 1, 'Ếch sơ chế,rửa thật sạch với nước muối loãng. Để thật ráo nước.', ''),
('ee15760f-fabb-4f1f-8300-5dd2dc991443', 2, 'Mix các hỗn hợp trên với nhau: sốt teriyaki, syrup, tương tách muối, dầu mè, mè trắng rang. Thêm vài muỗng nước lọc ấm. Khuấy đều', ''),
('ee15760f-fabb-4f1f-8300-5dd2dc991443', 3, 'Phi thơm dầu ăn với hành tỏi băm. Cho ếch vào xào xăn lại. Gắp ếch ra dĩa', ''),
('ee15760f-fabb-4f1f-8300-5dd2dc991443', 4, 'Cho phần sốt ở trên vào chảo. Hơi sôi lăn tăn thì cho ếch vào. Rim nhỏ lửa. Múc sốt rưới lên ếch, trở mặt để thịt ếch chín và thấm gia vị hơn.', ''),
('ee15760f-fabb-4f1f-8300-5dd2dc991443', 5, 'Sốt hơi cạn, thịt ếch chín thì tắt bếp cho ra dĩa là xong ạ 😘', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('ee15760f-fabb-4f1f-8300-5dd2dc991443', 300, 15.0, 25.0, 10.0, 3.0, 73.6, 2.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('ee15760f-fabb-4f1f-8300-5dd2dc991443', 'món ngon mỗi ngày'),
('ee15760f-fabb-4f1f-8300-5dd2dc991443', 'dễ làm');

-- Món ăn: Ếch Nấu Chuối
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('cdc275fc-27ac-4f74-a58f-07558605efcf', 'Ếch Nấu Chuối', 'Cách làm món Ếch Nấu Chuối ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/a6057c2dca956e59/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/15543342', 'Mi Huỳnh')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('cdc275fc-27ac-4f74-a58f-07558605efcf', 'Ếch', 'ếch', 'Tùy lượng', 1),
('cdc275fc-27ac-4f74-a58f-07558605efcf', 'Nghệ tươi', 'nghệ tươi', 'Tùy lượng', 1),
('cdc275fc-27ac-4f74-a58f-07558605efcf', 'cơm mẻ', 'cơm mẻ', 'Tùy lượng', 1),
('cdc275fc-27ac-4f74-a58f-07558605efcf', 'tía tô', 'tía tô', 'Tùy lượng', 1),
('cdc275fc-27ac-4f74-a58f-07558605efcf', 'chuối xanh', 'chuối xanh', 'Tùy lượng', 1),
('cdc275fc-27ac-4f74-a58f-07558605efcf', 'đậu hủ', 'đậu hủ', 'Tùy lượng', 1),
('cdc275fc-27ac-4f74-a58f-07558605efcf', 'ớt bột', 'ớt bột', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('cdc275fc-27ac-4f74-a58f-07558605efcf', 1, 'Ếch sau khi đã làm sạch,chặt miếng vừa ăn nêm với 1mcf tiêu, 1mcf hạt nêm, 1mcf ớt bột, 1mc đường, 1mc nước mắm', ''),
('cdc275fc-27ac-4f74-a58f-07558605efcf', 2, 'Nghệ tươi,tỏi băm nhỏ phi thơm cho thịt ếch,chuối vào xào đều -Cho nước mẻ,đậu hủ (đã chiên vàng) vào nấu cùng đến khi chuối chín mềm là được -Nêm gia vị lại cho vừa ăn rồi tắt bếp -Tía tô xắt nhỏ để vào cuối cùng', 'https://img-global.cpcdn.com/steps/a60cf517777e0eac/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('cdc275fc-27ac-4f74-a58f-07558605efcf', 420, 15.0, 55.0, 10.0, 3.0, 34.7, 1.6)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('cdc275fc-27ac-4f74-a58f-07558605efcf', 'món ngon mỗi ngày'),
('cdc275fc-27ac-4f74-a58f-07558605efcf', 'dễ làm');

-- Món ăn: Cháo ếch singrpore cho bé
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('cd7b6aed-1474-4bc4-be91-bee776a316a8', 'Cháo ếch singrpore cho bé', 'Cách làm món Cháo ếch singrpore cho bé ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/60ac414bb438ac54/1200x630cq80/photo.jpg', 30, 'Trung bình', '1ng', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/15514119', 'Mẹ Dâu ( Fb Trần Kiều ) 0971.492.563')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('cd7b6aed-1474-4bc4-be91-bee776a316a8', '1 con ếch', 'ếch', '1 con', 1),
('cd7b6aed-1474-4bc4-be91-bee776a316a8', 'Dầu hào', 'dầu hào', 'Tùy lượng', 1),
('cd7b6aed-1474-4bc4-be91-bee776a316a8', 'Nước tương cho bé', 'nước tương cho bé', 'Tùy lượng', 1),
('cd7b6aed-1474-4bc4-be91-bee776a316a8', 'Nước mắm cho bé', 'nước mắm cho bé', 'Tùy lượng', 1),
('cd7b6aed-1474-4bc4-be91-bee776a316a8', 'Nêm của bé', 'nêm của bé', 'Tùy lượng', 1),
('cd7b6aed-1474-4bc4-be91-bee776a316a8', 'Gừng + hành tím + hành lá', 'gừng + hành tím + hành lá', 'Tùy lượng', 1),
('cd7b6aed-1474-4bc4-be91-bee776a316a8', '2 nắm tay gạo + 1 nắm tay nếp', 'tay gạo + 1 nắm tay nếp', '2 nắm', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('cd7b6aed-1474-4bc4-be91-bee776a316a8', 1, 'Ếch mần sạch rửa với muối lấy chỉ máu để ráo đem ướp (3 muỗg cah nước tương + 1/2 nêm bé + 1 muỗg cf nước mắm + 2 muỗg cf đường + 2muôg cf dầu hào) ướp 30p', 'https://img-global.cpcdn.com/steps/bd11016b6c99ce4e/400x400cq80/photo.jpg'),
('cd7b6aed-1474-4bc4-be91-bee776a316a8', 2, 'Cho nồi lên bếp. Đổ dầu vào phi thơm hành tím băm + gừng cắt sợi phi thơm cho ếch vào xào xăn lại, đổ phần nước ướp lúc nảy vào. Kho lửa nhỏ.', 'https://img-global.cpcdn.com/steps/28f1b233f8d73da0/400x400cq80/photo.jpg'),
('cd7b6aed-1474-4bc4-be91-bee776a316a8', 3, 'Nước sốt : 2 muỗng cah nước tương của bé + 1m cf nước mắn của bé + 2m cf dầu hào + 2m cf đườg hc, khuấy điều lên, khi nào ếch kho gần cạn cho sốt vào kho tầm 4phut thấy sền sệt nêm lại xem vừa ăn chưa là được. Cho ít gừng + hàh lá vào tắt bếp. Chúc các mẹ thành công', 'https://img-global.cpcdn.com/steps/95d698a581e3540d/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('cd7b6aed-1474-4bc4-be91-bee776a316a8', 300, 15.0, 25.0, 10.0, 3.0, 78.3, 3.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('cd7b6aed-1474-4bc4-be91-bee776a316a8', 'món ngon mỗi ngày'),
('cd7b6aed-1474-4bc4-be91-bee776a316a8', 'dễ làm');

-- Món ăn: Ếch kho nghệ
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('b0b0b2b0-c689-4794-852b-7ca79ca232b9', 'Ếch kho nghệ', 'Cách làm món Ếch kho nghệ ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/9e05daef51ac9e39/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/15474163', 'Ching Ching')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('b0b0b2b0-c689-4794-852b-7ca79ca232b9', '1 con ếch', 'ếch', '1 con', 1),
('b0b0b2b0-c689-4794-852b-7ca79ca232b9', 'Bột nghệ', 'bột nghệ', 'Tùy lượng', 1),
('b0b0b2b0-c689-4794-852b-7ca79ca232b9', 'Hành tím băm', 'hành tím băm', 'Tùy lượng', 1),
('b0b0b2b0-c689-4794-852b-7ca79ca232b9', 'Hạt nêm em bé', 'hạt nêm em bé', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('b0b0b2b0-c689-4794-852b-7ca79ca232b9', 1, 'Ướp ếch với bột nghệ và hạt nêm 5-10’', ''),
('b0b0b2b0-c689-4794-852b-7ca79ca232b9', 2, 'Cho hành vào phi thơm rồi cho ếch vào thêm nước vào đun tầm khoảng 15-20’ nữa thì tắt bếp (mẹ nào có nước daishi thì càng tốt nha)', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('b0b0b2b0-c689-4794-852b-7ca79ca232b9', 300, 15.0, 25.0, 10.0, 3.0, 47.3, 3.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('b0b0b2b0-c689-4794-852b-7ca79ca232b9', 'món kho');

-- Món ăn: Chinese : Ếch Singapore (Kung Pao Frog Leg) Chuẩn vị Sing
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', 'Chinese : Ếch Singapore (Kung Pao Frog Leg) Chuẩn vị Sing', 'Cách làm món Chinese : Ếch Singapore (Kung Pao Frog Leg) Chuẩn vị Sing ngon tuyệt của nhà mình ;)', 'https://img-global.cpcdn.com/recipes/187b994a10aec31a/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/15462158', 'Taurus Sunny')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '8 con ếch', 'ếch', '8 con', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '20 quả ớt khô', 'ớt khô', '20 quả', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '6 bó hành lá', 'hành lá', '6 bó', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '4 tép tỏi', 'tỏi', '4 tép', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '2 mc Súp gà (Chicken broth concentrate)', 'mc súp gà', '2', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '4 mc Bột bắp', 'mc bột bắp', '4', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '2 mc dầu mè', 'mc dầu mè', '2', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', 'GIA VỊ ƯỚP : 👇', 'gia vị ướp', '👇', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '3 mc Xì dầu nhạt : light soy sauce', 'mc xì dầu nhạt : light soy sauce', '3', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '5 mc Hắc xì dầu : dark soy sauce', 'mc hắc xì dầu : dark soy sauce', '5', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '3 mc Dầu hào', 'mc dầu hào', '3', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '2,5 mc rượu Huatiao (Rượu gạo thiệu hưng)', 'mc rượu huatiao', '2,5', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '3 mcf đường', 'mcf đường', '3', 1),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', '2 mcf tiêu xay hoặc tiêu bột', 'mcf tiêu xay hoặc tiêu bột', '2', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', 1, 'Sơ chế ếch sạch sẽ, chặt ếch thành từng khúc vừa ăn. Ướp với các gia vị trên trong 1h - Hành tím củ bự cắt miếng vuông - Hành lá thái khúc dài - Tỏi thái lát', 'https://img-global.cpcdn.com/steps/091b16560ac1a086/400x400cq80/photo.jpg'),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', 2, 'Bắc chảo lên bếp, cho 2mc dầu mè, cho ớt khô và tỏi vào đảo cho vàng, thơm dậy mùi thì cho ếch vào xào cho săn. - Lấy 2mc súp gà với 500ml nước ấm (nếm thử xem gia vị vừa hay chưa) - Cho hết nước súp gà vào chảo ếch, đợi sôi thì mở lửa vừa 5 phút, cho hành tím vào.', 'https://img-global.cpcdn.com/steps/e045aba334d79ab5/400x400cq80/photo.jpg'),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', 3, 'Lấy 4mc bột bắp pha với 1 ít nước, trộn đều rồi từ từ cho vào chảo ếch, sốt sánh lại thì cho hành lá vào rồi tắt bếp là xong ! Múc ếch ra 1 nồi đất để giữ được nhiệt', 'https://img-global.cpcdn.com/steps/66289971b1769b17/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', 420, 33.0, 25.0, 18.0, 3.0, 72.9, 1.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', 'món ngon mỗi ngày'),
('4ccc4d9d-d090-4709-bbf8-9bc501f662c6', 'dễ làm');

-- Món ăn: Ếch xào củ hành, hẹ, bún tàu
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('18537123-29f6-4e08-897d-c78a3c92ae00', 'Ếch xào củ hành, hẹ, bún tàu', 'Công thức này mình học được trên youtube Mình đã thử và thành công nên mình muốn chia sẻ nó đến mọi người. Công thức rất đơn giản, người không giỏi bếp núc như mình vẫn làm được ạ 🥰', 'https://img-global.cpcdn.com/recipes/1e53e6df5461b02c/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/15462549', 'Huỳnh Đào')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('18537123-29f6-4e08-897d-c78a3c92ae00', 'Ếch 3 con (tầm nửa kí)', 'ếch 3 con', 'Tùy lượng', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', 'Hẹ', 'hẹ', 'Tùy lượng', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', '1/2 củ Hành tây', 'hành tây', '1/2 củ', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', '200 gr bún tàu', 'r bún tàu', '200 g', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', '4 tép tỏi', 'tỏi', '4 tép', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', 'Dầu ăn', 'dầu ăn', 'Tùy lượng', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', '2 muỗng canh đường', 'đường', '2 muỗng canh', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', '2 muỗng canh nước mắm', 'nước mắm', '2 muỗng canh', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', '1/2 chén nước trắng', 'nước trắng', '1/2 chén', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', '1 muỗng cf hạt nêm', 'cf hạt nêm', '1 muỗng', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', '1/2 muỗng cf muối', 'cf muối', '1/2 muỗng', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', '1/2 muỗng cf bột ngọt (nếu thích)', 'cf bột ngọt', '1/2 muỗng', 1),
('18537123-29f6-4e08-897d-c78a3c92ae00', '1/2 muỗng cf tiêu (nếu thích)', 'cf tiêu', '1/2 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('18537123-29f6-4e08-897d-c78a3c92ae00', 1, 'Ếch làm sạch bằng cách rửa với nước muối, sau đó rửa sạch lại với nước lạnh, để ráo nước.', ''),
('18537123-29f6-4e08-897d-c78a3c92ae00', 2, 'Hành tây, hẹ rửa sạch cắt khúc vừa ăn để ráo nước. Bún tàu ngâm nước lạnh 5p vớt ra để ráo.', 'https://img-global.cpcdn.com/steps/5b0f4187512f30ba/400x400cq80/photo.jpg'),
('18537123-29f6-4e08-897d-c78a3c92ae00', 3, 'Ướp ếch với: 2 tép tỏi băm 1 muỗng cf hạt nêm 1/2 muỗng cf bột ngọt 1/2 muỗng cf muối bọt Trộn đều để 30-45p cho thấm Sau đó đổ ngập dầu chiên vừa chín tới vớt ra để ráo', 'https://img-global.cpcdn.com/steps/08f5da7b4b059d1f/400x400cq80/photo.jpg'),
('18537123-29f6-4e08-897d-c78a3c92ae00', 4, 'Làm sốt xào ếch: 2 muỗng canh nước mắm 2 muỗng canh đường 1 muỗng canh tương ớt 1/4 muỗng cf bột ngọt 1/2 muỗng cf tiêu Nửa chén nước Khoấy đều', 'https://img-global.cpcdn.com/steps/98015a7a2d55cbfa/400x400cq80/photo.jpg'),
('18537123-29f6-4e08-897d-c78a3c92ae00', 5, 'Cho 1 muỗng canh dầu ăn vào chảo với 1 ít tỏi băm, dầu nóng cho sốt vừa làm vào nấu lửa vừa cho sệt lại rồi cho ếch vào đảo đều 5-7p cho hành tây, hẹ vào đảo đều nhanh tay (bạn nếm thử nếu thấy hơi mặn có thể cho thêm nửa chén nước) Thấy hành tây vừa chín tới thì cho bún tàu vào đảo đều tắt bếp và cho ra dĩa rắt tiêu cho thơm.', 'https://img-global.cpcdn.com/steps/512eb52f261d6304/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('18537123-29f6-4e08-897d-c78a3c92ae00', 420, 15.0, 55.0, 10.0, 3.0, 38.5, 4.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('18537123-29f6-4e08-897d-c78a3c92ae00', 'món xào');

-- Món ăn: Ếch chiên bơ tỏi
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('32855b3b-dfdf-4121-9a17-04524fc7b3f4', 'Ếch chiên bơ tỏi', 'Giãn cách xã hội, không có việc làm, chồng đi cắm câu được mấy con ếch. Ăn ếch xào xã ớt hoài chán quá, nay thử với món chiên bơ tỏi. Ăn cùng nước chấm thần thánh. Đổi món cho tụi nhỏ. #coginaudo #echchienbotoi', 'https://img-global.cpcdn.com/recipes/c675e2062c5ed9a5/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/15455086', 'Quyen Quach')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('32855b3b-dfdf-4121-9a17-04524fc7b3f4', '8 con ếch đồng lớn', 'ếch đồng lớn', '8 con', 1),
('32855b3b-dfdf-4121-9a17-04524fc7b3f4', '1 củ tỏi, 20gam bơ Tường An', 'tỏi, 20gam bơ tường an', '1 củ', 1),
('32855b3b-dfdf-4121-9a17-04524fc7b3f4', 'Dầu ăn, ngò để trang trí', 'dầu ăn, ngò để trang trí', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('32855b3b-dfdf-4121-9a17-04524fc7b3f4', 1, 'Ếch làm sạch, bỏ gân tanh, để da, rửa với ít dấm cho sạch nhớt trên da, sau đó massa với ít rượu, rửa kỹ lại với nước. Cắt làm 4. Để thật ráo để khi chiên không bị nổ văng', 'https://img-global.cpcdn.com/steps/0a67276b45edd47c/400x400cq80/photo.jpg'),
('32855b3b-dfdf-4121-9a17-04524fc7b3f4', 2, 'Cho dầu lên bếp, dầu nóng cho ếch vào chiên ngập dầu. Chiên ếch vàng dòn lấy ra rỗ cho kho dầu.', ''),
('32855b3b-dfdf-4121-9a17-04524fc7b3f4', 3, 'Bắt chảo lên bếp cho bơ vào, bơ nóng tan chảy, cho tỏi vào xào thơm, tiếp đến cho ếch vào xào nhanh.', ''),
('32855b3b-dfdf-4121-9a17-04524fc7b3f4', 4, 'Bày ra dĩa, trang trí lên 1 ít ngò, ăn cũng muối ớt xanh và xà lách trộn. Nhức nách luôn. 😋 Cả nhà mình thử và cho mình ý kiến nha.', 'https://img-global.cpcdn.com/steps/6ae7ca7782e8bac3/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('32855b3b-dfdf-4121-9a17-04524fc7b3f4', 400, 15.0, 25.0, 18.0, 3.0, 67.1, 2.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('32855b3b-dfdf-4121-9a17-04524fc7b3f4', 'chiên giòn');

-- Món ăn: Cơm lươn xốt Teriyaki mật ong với bơ và vừng đen
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('c4487830-aa62-47ae-ad29-581b524ba366', 'Cơm lươn xốt Teriyaki mật ong với bơ và vừng đen', 'Cơm lươn đơn giản lại ngon )))', 'https://img-global.cpcdn.com/recipes/28efa8335a0f535e/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 phần', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26412268', 'Hamy')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('c4487830-aa62-47ae-ad29-581b524ba366', '300 g Cơm trắng', 'cơm trắng', '300 g', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '200 g Lươn xốt Teriyaki mật ong (loại có sẵn)', 'lươn xốt teriyaki mật ong', '200 g', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '1 quả (khoảng 150g) Bơ chín mềm', 'bơ chín mềm', '1 quả', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '10 g Bơ lạt', 'bơ lạt', '10 g', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '1 thìa cà phê Vừng đen', 'vừng đen', '1 thìa cà phê', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '1 thìa cà phê Nước tương', 'nước tương', '1 thìa cà phê', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '1 thìa cà phê Dầu mè', 'dầu mè', '1 thìa cà phê', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '1 thìa cà phê Gừng tươi giã nhỏ', 'gừng tươi giã nhỏ', '1 thìa cà phê', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '2 thìa cà phê Nước gừng giã', 'nước gừng giã', '2 thìa cà phê', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '1/2 thìa cà phê (tùy chọn) Tiêu xay', 'tiêu xay', '1/2 thìa cà phê', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '1 thìa canh (tùy chọn) Hành lá thái nhỏ', 'hành lá thái nhỏ', '1 thìa canh', 1),
('c4487830-aa62-47ae-ad29-581b524ba366', '1/2 thìa cà phê (tùy chọn) Lá oregano khô', 'lá oregano khô', '1/2 thìa cà phê', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('c4487830-aa62-47ae-ad29-581b524ba366', 1, 'Ướp lươn với nước tương và nước gừng giã trong 10 phút cho thơm.', ''),
('c4487830-aa62-47ae-ad29-581b524ba366', 2, 'Áp chảo lươn cho vàng đều hai mặt, vớt ra để thấm bớt dầu.', ''),
('c4487830-aa62-47ae-ad29-581b524ba366', 3, 'Cho lươn đã áp chảo vào lại chảo, thêm bơ lạt, đảo nhẹ cho bơ tan và áo đều lươn.', ''),
('c4487830-aa62-47ae-ad29-581b524ba366', 4, 'Bật bếp, cho xốt Teriyaki mật ong vào chảo lươn, đun sôi và đảo nhẹ cho lươn thấm xốt.', ''),
('c4487830-aa62-47ae-ad29-581b524ba366', 5, 'Hạ nhỏ lửa, thêm dầu mè và một ít nước gừng giã, đảo đều cho xốt sệt lại.', ''),
('c4487830-aa62-47ae-ad29-581b524ba366', 6, 'Khi xốt sệt, rắc tiêu và hành lá nếu thích, đảo nhẹ rồi tắt bếp.', ''),
('c4487830-aa62-47ae-ad29-581b524ba366', 7, 'Bơ chín mềm cắt miếng vừa ăn.', ''),
('c4487830-aa62-47ae-ad29-581b524ba366', 8, 'Cho cơm trắng ra bát, xếp lươn, bơ chín lên trên, rắc lá oregano khô và vừng đen khi món ăn đã hoàn thiện.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('c4487830-aa62-47ae-ad29-581b524ba366', 420, 15.0, 55.0, 10.0, 3.0, 58.1, 3.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('c4487830-aa62-47ae-ad29-581b524ba366', 'món ngon mỗi ngày'),
('c4487830-aa62-47ae-ad29-581b524ba366', 'dễ làm');

-- Món ăn: Combo lươn 2 món
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('52599df3-36db-4f40-8a59-1724eb186fbd', 'Combo lươn 2 món', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/ee4b4e7dfcb79030/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26278159', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('52599df3-36db-4f40-8a59-1724eb186fbd', 'Cháo lươn', 'cháo lươn', 'Tùy lượng', 1),
('52599df3-36db-4f40-8a59-1724eb186fbd', 'Lươn chiên giòn', 'lươn chiên giòn', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('52599df3-36db-4f40-8a59-1724eb186fbd', 1, 'Cháo lươn', 'https://img-global.cpcdn.com/steps/067cb7113e2d86ed/400x400cq80/photo.jpg'),
('52599df3-36db-4f40-8a59-1724eb186fbd', 2, 'Lươn chiên giòn', 'https://img-global.cpcdn.com/steps/1276fa6ccba07706/400x400cq80/photo.jpg'),
('52599df3-36db-4f40-8a59-1724eb186fbd', 3, 'Combo lươn 2 món thơm ngon, hấp dẫn', 'https://img-global.cpcdn.com/steps/6ec31e42b6cdae2a/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('52599df3-36db-4f40-8a59-1724eb186fbd', 400, 15.0, 25.0, 18.0, 3.0, 48.3, 3.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('52599df3-36db-4f40-8a59-1724eb186fbd', 'món kho');

-- Món ăn: Lươn chiên giòn
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('9562384b-49db-4b15-8d81-4351dee9d7ca', 'Lươn chiên giòn', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/4ea74824b8204071/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/26279368', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('9562384b-49db-4b15-8d81-4351dee9d7ca', '400 g lươn', 'lươn', '400 g', 1),
('9562384b-49db-4b15-8d81-4351dee9d7ca', '1/3 mcf bột nghệ', 'mcf bột nghệ', '1/3', 1),
('9562384b-49db-4b15-8d81-4351dee9d7ca', '1/2 mcf hạt nêm', 'mcf hạt nêm', '1/2', 1),
('9562384b-49db-4b15-8d81-4351dee9d7ca', 'Ít tiêu xay 1', 'ít tiêu xay 1', 'Tùy lượng', 1),
('9562384b-49db-4b15-8d81-4351dee9d7ca', '2 mc bột bắp', 'mc bột bắp', '2', 1),
('9562384b-49db-4b15-8d81-4351dee9d7ca', '200 ml dầu ăn', 'dầu ăn', '200 ml', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('9562384b-49db-4b15-8d81-4351dee9d7ca', 1, 'Lươn ngâm rượu trắng 15 phút để tẩy mùi, sau đó cắt lát dọc ướp với các gia vị trên trong 30 phút', 'https://img-global.cpcdn.com/steps/12be57d0256bad2f/400x400cq80/photo.jpg'),
('9562384b-49db-4b15-8d81-4351dee9d7ca', 2, 'Cho bột bắp vào xóc đều rồi chiên giòn', 'https://img-global.cpcdn.com/steps/20a303cb8694a5ea/400x400cq80/photo.jpg'),
('9562384b-49db-4b15-8d81-4351dee9d7ca', 3, 'Rắc thêm ít vụn dừa sấy khô hoặc tỏi phi', 'https://img-global.cpcdn.com/steps/4f0e68d033e41c03/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('9562384b-49db-4b15-8d81-4351dee9d7ca', 400, 15.0, 25.0, 18.0, 3.0, 32.0, 1.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('9562384b-49db-4b15-8d81-4351dee9d7ca', 'chiên giòn');

-- Món ăn: Cháo lươn
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('d8a88960-f748-4906-ad52-2995cf5b7ad8', 'Cháo lươn', '#2026CookpadApron', 'https://img-global.cpcdn.com/recipes/7c5f6dd90a4aac80/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/26275767', 'Annie Vo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('d8a88960-f748-4906-ad52-2995cf5b7ad8', '1 kg phi lê lươn', 'phi lê lươn', '1 kg', 1),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', '2 lon gạo', 'on gạo', '2 l', 1),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', '50 g hành lá', 'hành lá', '50 g', 1),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', '1/2 mcf bột nghệ', 'mcf bột nghệ', '1/2', 1),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', '1 mcf hạt nêm', 'mcf hạt nêm', '1', 1),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', '1/2 mcf tiêu xay', 'mcf tiêu xay', '1/2', 1),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', '1 mc nước mắm', 'mc nước mắm', '1', 1),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', '2 mc dầu ăn', 'mc dầu ăn', '2', 1),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', '1/2 mcf ớt sa tế', 'mcf ớt sa tế', '1/2', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('d8a88960-f748-4906-ad52-2995cf5b7ad8', 1, 'Lươn ngâm rượu trắng 15 phút để tẩy mùi, sau đó cắt lát dọc ướp với các gia vị trên trong 30 phút. Gạo vo sạch, thêm nước nấu cháo với ít muối.', 'https://img-global.cpcdn.com/steps/6deb5b72ed6999e2/400x400cq80/photo.jpg'),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', 2, 'Phi thơm đầu hành, cho lươn vào xào nhẹ tay cho khỏi nát, thêm ít nước rim cho thấm vị với ít nước mắm', 'https://img-global.cpcdn.com/steps/d19fd515e7895e9b/400x400cq80/photo.jpg'),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', 3, 'Cháo chín múc ra tô, thêm lươn và nước rim, cuối cùng thêm hành lá và tiêu xay', 'https://img-global.cpcdn.com/steps/f1ad8f552af9f37b/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('d8a88960-f748-4906-ad52-2995cf5b7ad8', 300, 15.0, 25.0, 10.0, 3.0, 37.7, 2.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('d8a88960-f748-4906-ad52-2995cf5b7ad8', 'món ngon mỗi ngày'),
('d8a88960-f748-4906-ad52-2995cf5b7ad8', 'dễ làm');

-- Món ăn: Lươn Teriyaki siêu dễ
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', 'Lươn Teriyaki siêu dễ', 'Đi chợ mua được mấy con lươn đồng tươi ngon, 150k/kg/5 con. Mấy bạn ở nhà thích ăn cơm lươn teriyaki nên mình làm món này. Lươn Việt Nam mình siêu ngon, làm món này thì siêu dễ siêu nhanh, ngon bổ rẻ hơn lươn teriyaki nhật đóng gói sẵn ạ.', 'https://img-global.cpcdn.com/recipes/af8dad3cacea2be5/1200x630cq80/photo.jpg', 30, 'Trung bình', '10 phần', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25805768', 'minh!')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', '1 kg lươn đồng', 'lươn đồng', '1 kg', 1),
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', '1 khóm tỏi', 'khóm tỏi', '1', 1),
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', '2 khóm hành', 'khóm hành', '2', 1),
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', '5 muỗng canh dầu ô liu nguyên chất', 'dầu ô liu nguyên chất', '5 muỗng canh', 1),
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', '6 muỗng canh xì dầu Kikkoman', 'xì dầu kikkoman', '6 muỗng canh', 1),
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', '3 muỗng canh đường nâu', 'đường nâu', '3 muỗng canh', 1),
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', '1 muỗng cà phê bột gừng hoặc 1 củ gừng tươi', 'bột gừng hoặc 1 củ gừng tươi', '1 muỗng cà phê', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', 1, 'Lươn đã được làm sạch, lọc xương (nhờ bác bán lươn làm giúp).', 'https://img-global.cpcdn.com/steps/e50d65313f87aeb5/400x400cq80/photo.jpg'),
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', 2, 'Hành tỏi bóc vỏ, băm nhỏ, cho vào chảo với dầu ô liu, bật lửa 100C. Xào chừng 2 phút cho thơm. Cho đường, xì dầu, gừng vào đảo đều.', 'https://img-global.cpcdn.com/steps/679b80e7fddfa167/400x400cq80/photo.jpg'),
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', 3, 'Chảo mình chỉ để vừa 3 con, nên chia ra làm 2 đợt :D mỗi lần khoảng 10 phút, lật qua lật lại 2-3 lần là được, lên màu óng vàng ươm.', 'https://img-global.cpcdn.com/steps/6d40911f68a502c1/400x400cq80/photo.jpg'),
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', 4, 'Tắt bếp, lấy ra đĩa. Thưởng thức thôi :D', 'https://img-global.cpcdn.com/steps/6f10f185668a1a8d/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', 300, 15.0, 25.0, 10.0, 3.0, 54.5, 3.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', 'món ngon mỗi ngày'),
('7a0f79b0-d5fd-40fb-b49f-dddb98c469aa', 'dễ làm');

-- Món ăn: Lươn nướng nckd
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('bdc12f73-982a-4f0e-87c9-a27bc698c93d', 'Lươn nướng nckd', '#cookpadapron2025 tuần 34', 'https://img-global.cpcdn.com/recipes/eae5f151cc427d29/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/25235288', 'Thu Mèo')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('bdc12f73-982a-4f0e-87c9-a27bc698c93d', '1 con lươn 300gr', 'lươn 300gr', '1 con', 1),
('bdc12f73-982a-4f0e-87c9-a27bc698c93d', '1 g sốt nướng sả ớt', 'sốt nướng sả ớt', '1 g', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('bdc12f73-982a-4f0e-87c9-a27bc698c93d', 1, 'Lươn mình nhờ người bán làm sạch luôn,về chỉ cần rửa sạch lại,cắt khúc vừa ăn,ướp lươn vs gói sốt nướng 20p cho ngấm gia vị', ''),
('bdc12f73-982a-4f0e-87c9-a27bc698c93d', 2, 'Làm nóng ncdk 180° trong 50,xếp lươn vào nướng 180° trong 20p,10p lật mặt 1 lần để lươn chín vàng đều là ok,ăn kèm vs cơm nóng', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('bdc12f73-982a-4f0e-87c9-a27bc698c93d', 400, 15.0, 25.0, 18.0, 3.0, 45.9, 4.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('bdc12f73-982a-4f0e-87c9-a27bc698c93d', 'món ngon mỗi ngày'),
('bdc12f73-982a-4f0e-87c9-a27bc698c93d', 'dễ làm');

-- Món ăn: Lươn Kho Củ Nén
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 'Lươn Kho Củ Nén', '#CookpadApron2025 #Tuan15 #CuNen #HanhTam Có nhiều món ăn từ lươn đã trở thành đặc sản nổi tiếng ở vùng đất Nghệ An. Trong đó, món Lươn Kho Củ Nén thường xuất hiện trong các bữa cơm gia đình ở Nghệ An, nơi vị ngọt tự nhiên của củ cải trắng hòa quyện cùng độ béo ngậy của lươn đồng ướp đậm đà với nước mắm nhĩ, tiêu xay, bột nghệ và đặc biệt là củ nén giã dập được phi trong dầu nóng – thứ gia vị đặc trưng mang đến mùi thơm không lẫn vào đâu được. Tất cả cùng hoà quyện và tạo nên một món ăn là sự chắt lọc tinh túy về hương vị của miền Trung nắng gió… #LuonKhoCuNen #HuynhPhatKitchen', 'https://img-global.cpcdn.com/recipes/23b4af51320b435b/1200x630cq80/photo.jpg', 30, 'Trung bình', '5 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24866798', 'Huỳnh Phát')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '600 gam lươn', 'am lươn', '600 g', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '300 gam củ cải trắng', 'am củ cải trắng', '300 g', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '60 gam củ nén', 'am củ nén', '60 g', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '3 tbsp dầu ăn', 'dầu ăn', '3 tbsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '1 tbsp hành tím băm', 'hành tím băm', '1 tbsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '1 tbsp tỏi băm', 'tỏi băm', '1 tbsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '1.5 tsp tiêu', 'tiêu', '1.5 tsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '1/2 tsp bột ngọt', 'bột ngọt', '1/2 tsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '1 tbsp hạt nêm', 'hạt nêm', '1 tbsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '2 tbsp đường', 'đường', '2 tbsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '3 tbsp nước mắm', 'nước mắm', '3 tbsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '2 tbsp dầu màu điều', 'dầu màu điều', '2 tbsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '1/2 tbsp nước màu', 'nước màu', '1/2 tbsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '1/2 tbsp bột nghệ', 'bột nghệ', '1/2 tbsp', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '1 trái ớt sừng', 'ớt sừng', '1 trái', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '2 nhánh ngò gai', 'ngò gai', '2 nhánh', 1),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', '3 trái ớt hiểm (nếu không thích ăn cay thì không dùng)', 'ớt hiểm', '3 trái', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 1, 'Lươn làm rửa sạch. Sau đó, ta dùng dao bén, khứa khoảng 4 khứa mỏng trên lưng lươn rồi mới cắt khúc. Cách này sẽ giúp ta khi ướp lươn sẽ mau thấm gia vị hơn.', 'https://img-global.cpcdn.com/steps/d972ea58f45d60d7/400x400cq80/photo.jpg'),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 2, 'Củ nén rửa sạch, lột vỏ… Củ cải trắng gọt vỏ, chẻ đôi rồi cắt khúc vừa ăn.', 'https://img-global.cpcdn.com/steps/b1a3c1d720ef9697/400x400cq80/photo.jpg'),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 3, 'Để pha xốt ướp lươn, ta bắc chảo lên bếp, cho vô đó 3tbsp dầu ăn. Khi dầu nóng, ta cho củ nén vô phi trước. Củ nén vừa thơm, ta hạ lửa nhỏ rồi cho: 1tbsp hành tím băm + 1tbsp tỏi băm + 3tbsp nước lọc + 1tsp tiêu + 1/2tsp bột ngọt + 1.5tbsp hạt nêm + 2tbsp đường + 3tbsp nước mắm + 2tbsp dầu màu điều + 1/2tbsp nước màu + 1/2tbsp bột nghệ. Nấu cho tất cả hoà quyện lại rồi tắt bếp để nguội.', 'https://img-global.cpcdn.com/steps/67bef8851d85e70f/400x400cq80/photo.jpg'),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 4, 'Cho tất cả phần nước xốt đã nguội bớt vào lươn. Trộn thật đều cho lươn hoà quyện gia vị. Sau đó, ta để khoảng 5 phút cho thấm.', 'https://img-global.cpcdn.com/steps/d7ad60832f1c18d1/400x400cq80/photo.jpg'),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 5, 'Cho phần lươn đã ướp xốt vô nồi, bắc lên bếp để kho trên lửa vừa. Chú ý đảo đều cho đến khi thịt lươn săn lại thì ta cho củ cái trắng vào chung và đảo đều.', 'https://img-global.cpcdn.com/steps/7a06c42d70d5531d/400x400cq80/photo.jpg'),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 6, 'Khi củ cải thấm gia vị và nước xốt ướp sắp cạn, ta cho vô nồi 1.5 chén nước dừa tươi cho vừa ngập các nguyên liệu. Tiếp tục nấu trên lửa vừa cho lươn và củ cải chín. Lúc đó, ta xắt một ít ớt sừng rồi thả vô nồi lươn. (Nếu thích cay nhiều, bạn có thể đập giập thêm vài trái ớt hiểm cho vô).', 'https://img-global.cpcdn.com/steps/311bd5ea7fa70de6/400x400cq80/photo.jpg'),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 7, 'Trong lúc đó, ta xắt sẵn một ít ngò gai. Đợi khi nước xốt trong nồi lươn sánh lại còn một nửa, ta cho ngò gai đã xắt vô và rắc thêm một ít tiêu rồi tắt bếp.', 'https://img-global.cpcdn.com/steps/09574b4b125e834d/400x400cq80/photo.jpg'),
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 8, 'Cho món ăn ra dĩa và thưởng thức cùng với cơm nóng.', 'https://img-global.cpcdn.com/steps/616fd40b510218a7/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 300, 15.0, 31.0, 10.0, 6.5, 71.6, 1.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('6150e791-7e93-43cf-bd40-f7d6af0e4b7e', 'món kho');

-- Món ăn: Lươn Xào Lăn
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', 'Lươn Xào Lăn', '#CookpadApron2025 #Tuan12 Với hương sả và mùi cà ri thơm nồng, nước cốt dừa béo ngậy, món Lươn Xào Lăn là sự kết hợp hài hòa giữa vị cay nồng, ngọt béo và đậm đà, dễ làm xiêu lòng cả những thực khách khó tính. Những khúc lươn mềm ngọt, thấm đều gia vị, quyện cùng mùi thơm đặc trưng của nghệ, cà ri, sả và vị thơm béo của nước cốt dừa đã tạo nên một món ăn đầy hấp dẫn. Đặc biệt, không chỉ dùng làm món ăn chính trong bữa cơm gia đình, món ăn này lại có thể làm một món “đưa cay” của nhóm bạn bè thân hữu vừa lai rai, nhâm nhi cùng tí xíu men nồng của vài ly rượu thơm hoặc mấy lon bia mát lạnh, vừa thưởng thức một món ăn dân dã nhưng lại là “đặc sản hương vị” của ẩm thực miền Nam… #LuonXaoLan #MonLaiRai #HuynhPhatKitchen', 'https://img-global.cpcdn.com/recipes/f442d18f801b3779/1200x630cq80/photo.jpg', 30, 'Trung bình', '4-5 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/24259694', 'Huỳnh Phát')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '600 gam lươn', 'am lươn', '600 g', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '300 ml nước cốt dừa loãng (nước dão)', 'nước cốt dừa loãng', '300 ml', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '100 ml nước cốt dừa đậm đặc (nước cốt)', 'nước cốt dừa đậm đặc', '100 ml', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1.5 tsp bột cà ri', 'bột cà ri', '1.5 tsp', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1 tsp bột nghệ', 'bột nghệ', '1 tsp', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1 tbsp nước mắm', 'nước mắm', '1 tbsp', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1 tbsp đường', 'đường', '1 tbsp', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1/2 tbsp hạt nêm', 'hạt nêm', '1/2 tbsp', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1/4 tsp bột ngọt', 'bột ngọt', '1/4 tsp', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1/2 tsp tiêu xay', 'tiêu xay', '1/2 tsp', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '3 nhánh sả', 'sả', '3 nhánh', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1 tbsp hành tím băm', 'hành tím băm', '1 tbsp', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1 tbsp tỏi băm', 'tỏi băm', '1 tbsp', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '3 tbsp dầu ăn', 'dầu ăn', '3 tbsp', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1 nhánh ngò gai', 'ngò gai', '1 nhánh', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '4 nhánh rau om', 'rau om', '4 nhánh', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '2 cái nấm mèo khô', 'nấm mèo khô', '2 cái', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1 củ hành tây', 'hành tây', '1 củ', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '10 gam miến', 'am miến', '10 g', 1),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', '1 nắm đậu phộng rang', 'đậu phộng rang', '1 nắm', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', 1, 'Lươn làm sạch rồi cắt khúc khoảng 5–7 cm. Ướp lươn với: 1.5tsp bột cà ri + 1tsp bột nghệ + 1tbsp nước mắm + 1tbsp đường + 1/2tbsp hạt nêm + 1/4tsp bột ngọt + 1/2tsp tiêu. Trộn đều và để 15 phút cho thấm. Cho 3tbsp dầu ăn vô chảo. Khi dầu nóng, ta cho 3 gốc sả đập giập, cắt khúc vô phi. Đến khi sản đã thơm, ta cho 1tbsp hành tím + 1tbsp tỏi vô phi chung cho thơm.', 'https://img-global.cpcdn.com/steps/6a08a548b9c1e066/400x400cq80/photo.jpg'),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', 2, 'Cho lươn đã ướp vô chảo, xào trên lửa lớn cho lươn săn lại. Ta có thể cho vô chảo 1-2tbsp nước để tránh khét chảo.', 'https://img-global.cpcdn.com/steps/623eee4d7586e026/400x400cq80/photo.jpg'),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', 3, 'Khi lươn đã săn, ta đổ nước cốt dừa (phần loãng) vô chảo. Khi nước dừa bắt đầu sôi thì ta hạ nhỏ lửa, và tiếp tục nấu… Lần lượt cho nấm mèo ngâm nở xắt sợi vô chảo. Khi nấm mèo chín, ta cho miến đã ngâm mềm và xắt khúc vô chảo lươn để nấu cùng.', 'https://img-global.cpcdn.com/steps/302fc1e64a14a0b1/400x400cq80/photo.jpg'),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', 4, 'Khi miến đã mềm, ta cho phần nước cốt dừa đậm đặc vô chảo. Để lửa nhỏ để tiếp tục um lươn. Nêm nếm lại gia vị cho vừa ăn. Cho hành tây xắt múi cau và ngò gai, rau om xắt nhỏ vô chảo lươn, đảo đều rồi tắt bếp.', 'https://img-global.cpcdn.com/steps/947edf8832f7b6b6/400x400cq80/photo.jpg'),
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', 5, 'Cho món ăn ra dĩa, rắc một ít ngò gai, rau om lên mặt. Nếu thích, ta có thể cho một ít đậu phộng rang giã nhỏ lên trên… Sau đó dọn lên dùng với cơm, bún, bánh mì như món chính hoặc dùng làm một món lai rai với bè bạn, gia đình đều rất ngon…', 'https://img-global.cpcdn.com/steps/52d09ae3fcf18179/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', 300, 15.0, 31.0, 10.0, 6.5, 34.7, 1.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('e8b546ff-f7bb-48ef-b5c2-ceaa4284ea3f', 'món xào');

-- Món ăn: Cà ri lươn
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 'Cà ri lươn', 'Chấm bánh mì hay ăn với bún cũng ngon. Riêng mình thì làm nhiều chút. Tối ăn với bún. Sáng chấm bánh mì cho nó đã cái nư.', 'https://img-global.cpcdn.com/recipes/921a5b61b30df60c/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/24526201', 'Amy Ruan')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 'Mình lười ghi nguyên liệu quá. Mọi người cứ đọc cách làm rồi tới loai nào không có thì ghi ra ngoài dù gì cũng phải đi mua ☺️', 'mình lười ghi nguyên liệu quá. mọi người cứ đọc cách làm rồi tới loai nào không có thì ghi ra ngoài dù gì cũng phải đi mua', 'Tùy lượng', 1),
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 'lươn', 'lươn', 'Tùy lượng', 1),
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 'bột cari', 'bột cari', 'Tùy lượng', 1),
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 'cari', 'cari', 'Tùy lượng', 1),
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 'hành tây múi cau', 'hành tây múi cau', 'Tùy lượng', 1),
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 'cà rốt tỉa hoa', 'cà rốt tỉa hoa', 'Tùy lượng', 1),
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 'nấm hương và hành tây', 'nấm hương và hành tây', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 1, 'Cho lươn vào rổ, thêm chút muối và nước cốt chanh hoặc giấm, dùng tay chà xát thật mạnh để làm hết nhớt và vị tanh của lươn. Sau đó, rửa lươn lại với nước sạch và cắt thành khúc vừa. Ướp lươn với bột cari, bột nêm, tỏi, sả đập dập, cắt khúc,tiêu, chút đang phèn (không sd nước mắm cho việc nấu cari), ướp qua đêm cho cà ri thấm vô lươn', ''),
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 2, 'Cho bơ vào chảo, cắt hành tây thành múi cau, cà rốt tỉa hoa, xào sơ carrot, nấm hương và hành tây', ''),
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 3, 'Sau khi ướp, cho dầu vào chảo, fi thơm tỏi, thêm gừng băm vào + ớt nguyên trái khô, cho hỗn hợp cari đã ướp vào đảo đều cho lươn săn lại, gắp lươn ra chén, cho nước nóng vào và đun với lửa liu riu cho carrot chín mềm, khi cà rốt chín, cho sữa tuơi, lươn và nước cốt dừa vào, đun khoảng 5-10p tắt bếp, không nên nấu cari với lửa to, nêm nếm cho vừa ăn', ''),
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 4, 'Gia vị mình chỉ nói sơ thứ tự nêm nếm. Còn định lượng thì mọi người tự điều chỉnh theo khẩu vị của mình nhé. Chúc mọi người ăn ngon miệng 💋', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 500, 31.0, 61.0, 14.0, 6.5, 63.1, 4.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 'món ngon mỗi ngày'),
('9100b9b8-d7a5-46f1-92fe-0bcc6ea1b3ea', 'dễ làm');

-- Món ăn: Lươn đồng xào rau ngổ
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('aa0055d1-240a-442d-91b1-1763588fbb15', 'Lươn đồng xào rau ngổ', '#GlobalApron2024 #Raugiavi Lươn đồng xào lá ngổ, thêm ít nhánh sả, món này phải kết hợp đủ cả hai loại rau gia vị trên, thêm chút cay mới đậm đà.', 'https://img-global.cpcdn.com/recipes/b9982b36576f64af/1200x630cq80/photo.jpg', 30, 'Trung bình', '5 người', 'Món phụ', 'https://cookpad.com/vn/cong-thuc/23973037', 'Bếp của Quỳnh')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('aa0055d1-240a-442d-91b1-1763588fbb15', '1 kg lươn đồng đã làm sạch (5 -6 con)', 'lươn đồng đã làm sạch', '1 kg', 1),
('aa0055d1-240a-442d-91b1-1763588fbb15', '100 gram sả cây', 'ram sả cây', '100 g', 1),
('aa0055d1-240a-442d-91b1-1763588fbb15', '100 gram rau ngổ (ngò om)', 'ram rau ngổ', '100 g', 1),
('aa0055d1-240a-442d-91b1-1763588fbb15', '5 củ hành tím', 'hành tím', '5 củ', 1),
('aa0055d1-240a-442d-91b1-1763588fbb15', '1 củ tỏi', 'tỏi', '1 củ', 1),
('aa0055d1-240a-442d-91b1-1763588fbb15', '5 trái ớt đỏ, xanh', 'ớt đỏ, xanh', '5 trái', 1),
('aa0055d1-240a-442d-91b1-1763588fbb15', '1 củ hành tây, vài nhánh hành lá', 'hành tây, vài nhánh hành lá', '1 củ', 1),
('aa0055d1-240a-442d-91b1-1763588fbb15', 'Gia vị: dầu ăn, ớt bột, mắm, muối, dấm, hạt nêm, tiêu', 'gia vị', 'dầu ăn, ớt bột, mắm, muối, dấm, hạt nêm, tiêu', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('aa0055d1-240a-442d-91b1-1763588fbb15', 1, 'Lươn đồng đã làm sạch chà với muối, dấm nhiều lần cho ra nhớt, rửa kĩ nhiều lần, để ráo, cắt đoạn. Ướp lươn với 2 thìa hạt nêm, 2 thìa mắm, 1 thìa ớt bột, tiêu và ướp trong khoảng từ 30-60 phút.', 'https://img-global.cpcdn.com/steps/f98cf760de8c9cd0/400x400cq80/photo.jpg'),
('aa0055d1-240a-442d-91b1-1763588fbb15', 2, 'Sả, hành, tỏi, ớt băm nhỏ, để riêng từng loại. Rau ngổ, hành lá rửa sạch rồi xắt đoạn. Hành tây lột vỏ, rửa sạch, cắt hình múi cau.', 'https://img-global.cpcdn.com/steps/23c1141ee9409590/400x400cq80/photo.jpg'),
('aa0055d1-240a-442d-91b1-1763588fbb15', 3, 'Xào lươn: Tao dầu với hành tím, tỏi và sả băm còn lại, thêm ớt bột để tạo màu, cho lươn đã ướp vào xào, đảo nhanh tay, hạ lửa nhỏ, nêm thêm mắm, hạt nêm, ớt cho vừa khẩu vị, xào khoảng 15 phút cho lươn thấm gia vị thì tắt bếp, cho rau ngổ, hành lá và hành tây vào chảo, đảo rồi múc ra dĩa, rắc tiêu, ăn nóng.', 'https://img-global.cpcdn.com/steps/a633f1e9e4c216cb/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('aa0055d1-240a-442d-91b1-1763588fbb15', 300, 15.0, 31.0, 10.0, 6.5, 59.3, 3.7)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('aa0055d1-240a-442d-91b1-1763588fbb15', 'món xào');

-- Món ăn: Lươn thịt cuộn lá lốt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('ce3fe912-c8cf-4967-8168-dca855abc275', 'Lươn thịt cuộn lá lốt', '#12thangbepvui', 'https://img-global.cpcdn.com/recipes/540fcfa5aa3a7396/1200x630cq80/photo.jpg', 30, 'Trung bình', 'bốn người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/17313993', 'Pham Huyen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('ce3fe912-c8cf-4967-8168-dca855abc275', '200 g thịt', 'thịt', '200 g', 1),
('ce3fe912-c8cf-4967-8168-dca855abc275', '200 g thịt lươn đã làm sẵn', 'thịt lươn đã làm sẵn', '200 g', 1),
('ce3fe912-c8cf-4967-8168-dca855abc275', 'Lá lốt, gia vị', 'lá lốt, gia vị', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('ce3fe912-c8cf-4967-8168-dca855abc275', 1, 'Lá lốt rửa sạch cắt nhỏ vài lá, băm nhỏ 1 củ hành, trộn vào thịt nạc xay với 1/2 thìa canh mắm, 1/4 thìa cf tiêu, trộn đều để 15 phút cho thấm.', 'https://img-global.cpcdn.com/steps/920495863a8649f6/400x400cq80/photo.jpg'),
('ce3fe912-c8cf-4967-8168-dca855abc275', 2, 'Lươn rửa sạch với chanh, cắt thành từng miếng ngang thân lươn khoảng 3 cm, ướp lươn với hành tỏi băm nhỏ 1/2 thìa cà phê bột nghệ 1/2 thìa canh nước mắm trộn đều.', 'https://img-global.cpcdn.com/steps/1d13befcc0a3a363/400x400cq80/photo.jpg'),
('ce3fe912-c8cf-4967-8168-dca855abc275', 3, 'Trải lá lốt ra, lấy một chút thịt băm, đặt miếng lươn lên trên rồi cuộn lá lốt lại, gài chặt chả bằng cuống lá.', 'https://img-global.cpcdn.com/steps/ee56e1e447cabf72/400x400cq80/photo.jpg'),
('ce3fe912-c8cf-4967-8168-dca855abc275', 4, 'Cho lá lốt lên chảo chiên trong lửa vừa, đến khi chín gắp ra đĩa và thưởng thức.', 'https://img-global.cpcdn.com/steps/9ceb8b5b82d98c02/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('ce3fe912-c8cf-4967-8168-dca855abc275', 300, 15.0, 25.0, 10.0, 3.0, 37.8, 2.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('ce3fe912-c8cf-4967-8168-dca855abc275', 'món ngon mỗi ngày'),
('ce3fe912-c8cf-4967-8168-dca855abc275', 'dễ làm');

-- Món ăn: Bún lươn xào nghệ Cà Mèn
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('e1d30250-1497-4728-bb09-7649b46f034e', 'Bún lươn xào nghệ Cà Mèn', 'Thèm món bún nghệ tươi, mà tìm nguyên liệu khó quá, nhờ biết được Cà Mèn nên tớ làm thử! Ngon tuyệt cú mèo nhé mọi người.', 'https://img-global.cpcdn.com/recipes/5b378c2c7f913ec7/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/23910927', 'Hai Vo Hoang')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('e1d30250-1497-4728-bb09-7649b46f034e', '1 gói bún lươn cà mèn', 'ói bún lươn cà mèn', '1 g', 1),
('e1d30250-1497-4728-bb09-7649b46f034e', '20 ml nước', 'nước', '20 ml', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('e1d30250-1497-4728-bb09-7649b46f034e', 1, 'Bóc gói bún lươn', 'https://img-global.cpcdn.com/steps/739cc6fcbc45862f/400x400cq80/photo.jpg'),
('e1d30250-1497-4728-bb09-7649b46f034e', 2, 'Hấp cách thuỷ phần bún trong 5 phút', ''),
('e1d30250-1497-4728-bb09-7649b46f034e', 3, 'Cho nước vào gói sổt và gói thịt lươn đảo trên chảo lửa nhỏ trong 2 phút', 'https://img-global.cpcdn.com/steps/f278164073eca01c/400x400cq80/photo.jpg'),
('e1d30250-1497-4728-bb09-7649b46f034e', 4, 'Bún hấp cách thuỷ vớt sang đưa vào chảo đảo đều trong 2-3 phút', ''),
('e1d30250-1497-4728-bb09-7649b46f034e', 5, 'Đến khi sệt hết nước sốt, vàng tắt bếp dọn ra đĩa măm măm', 'https://img-global.cpcdn.com/steps/5515119ffb959fde/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('e1d30250-1497-4728-bb09-7649b46f034e', 420, 15.0, 55.0, 10.0, 3.0, 23.1, 3.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('e1d30250-1497-4728-bb09-7649b46f034e', 'món xào');

-- Món ăn: Lươn Kho Tiêu
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('14496048-5bf5-44ed-814b-c8182e92a3e7', 'Lươn Kho Tiêu', '#bingo #Globalapron2024', 'https://img-global.cpcdn.com/recipes/e2322136bf1d2cea/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 phần ăn', 'Món chính', 'https://cookpad.com/vn/cong-thuc/17301720', 'Rose Truong')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('14496048-5bf5-44ed-814b-c8182e92a3e7', '250 g thịt lươn', 'thịt lươn', '250 g', 1),
('14496048-5bf5-44ed-814b-c8182e92a3e7', '2 củ hành tím', 'hành tím', '2 củ', 1),
('14496048-5bf5-44ed-814b-c8182e92a3e7', '1 muỗng cafe tiêu xay', 'cafe tiêu xay', '1 muỗng', 1),
('14496048-5bf5-44ed-814b-c8182e92a3e7', '1 ít ớt (tuỳ thích)', 'ớt', '1 ít', 1),
('14496048-5bf5-44ed-814b-c8182e92a3e7', '2 muỗng mắm', 'mắm', '2 muỗng', 1),
('14496048-5bf5-44ed-814b-c8182e92a3e7', '3 muỗng dầu ăn', 'dầu ăn', '3 muỗng', 1),
('14496048-5bf5-44ed-814b-c8182e92a3e7', '1 muỗng đường nâu', 'đường nâu', '1 muỗng', 1),
('14496048-5bf5-44ed-814b-c8182e92a3e7', '1 ít bột ngọt (tuỳ thích)', 'bột ngọt', '1 ít', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('14496048-5bf5-44ed-814b-c8182e92a3e7', 1, 'Cho dầu ăn và hành tím, ớt vào nồi nấu lên cho dậy mùi thơm rồi tắc bếp cho thêm đường nâu (hoặc dùng đường trắng thì cho thêm ít nước màu hàng) nấu sôi lên rồi cho lươn vào ướp 15 phút.', 'https://img-global.cpcdn.com/steps/ad51f942bb49f2f7/400x400cq80/photo.jpg'),
('14496048-5bf5-44ed-814b-c8182e92a3e7', 2, 'Sau đó nấu lên để nhỏ lửa lại nấu đến khi còn lại ít nước là được.', 'https://img-global.cpcdn.com/steps/004fd7c19e6cfc8d/400x400cq80/photo.jpg'),
('14496048-5bf5-44ed-814b-c8182e92a3e7', 3, 'Đây là món bổ dưỡng khá ngon, có thể ăn cùng rau luộc, dưa leo.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('14496048-5bf5-44ed-814b-c8182e92a3e7', 300, 15.0, 25.0, 10.0, 3.0, 68.7, 1.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('14496048-5bf5-44ed-814b-c8182e92a3e7', 'món kho');

-- Món ăn: Miến xào lươn, cà rốt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('431d624b-f347-493a-a64f-cfa99f66c82a', 'Miến xào lươn, cà rốt', '#GlobalApron2024 #Bingo', 'https://img-global.cpcdn.com/recipes/8839446e6dfea8ce/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/17294525', 'Pham Huyen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('431d624b-f347-493a-a64f-cfa99f66c82a', '200 g lươn làm sạch', 'lươn làm sạch', '200 g', 1),
('431d624b-f347-493a-a64f-cfa99f66c82a', '100 g miến', 'miến', '100 g', 1),
('431d624b-f347-493a-a64f-cfa99f66c82a', '1 củ cà rốt', 'cà rốt', '1 củ', 1),
('431d624b-f347-493a-a64f-cfa99f66c82a', 'Hành, rau răm', 'hành, rau răm', 'Tùy lượng', 1),
('431d624b-f347-493a-a64f-cfa99f66c82a', '5 tai nấm hương, 2 tai mộc nhĩ, 2 củ hành, 1/2 củ tỏi, gừng', 'tai nấm hương, 2 tai mộc nhĩ, 2 củ hành, 1/2 củ tỏi, gừng', '5', 1),
('431d624b-f347-493a-a64f-cfa99f66c82a', 'Tiêu, ớt, bột nghệ, gia vị, hành phi', 'tiêu, ớt, bột nghệ, gia vị, hành phi', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('431d624b-f347-493a-a64f-cfa99f66c82a', 1, 'Miến ngâm nước cho mềm rồi vớt ra để ráo, cắt ngắn; lươn cắt ngang, mỏng tầm 2mm. Lươn ướp với hành, tỏi băm nhỏ, 1/2 thìa cf bột nghệ, 1 xíu mắm, 1 ít tiêu để 15 phút.', 'https://img-global.cpcdn.com/steps/f3cbedd276a74f93/400x400cq80/photo.jpg'),
('431d624b-f347-493a-a64f-cfa99f66c82a', 2, 'Cà rốt bào sợi, nấm hương, mộc nhĩ cắt sợi, gừng cắt sợi.', 'https://img-global.cpcdn.com/steps/d8d5356bf5037d2c/400x400cq80/photo.jpg'),
('431d624b-f347-493a-a64f-cfa99f66c82a', 3, 'Phi thơm hành tỏi, cho lươn vào xào săn rồi để riêng. Cho mộc nhĩ, nấm hương, cà rốt, gừng vào xào đến khi cà rốt chín mềm.', 'https://img-global.cpcdn.com/steps/b64cf7f57f940b34/400x400cq80/photo.jpg'),
('431d624b-f347-493a-a64f-cfa99f66c82a', 4, 'Chế sốt xào miến: 2 thìa canh nước tương, 1 thìa canh dầu hào, 2 thìa canh nước tương, 2 thìa canh nước khuấy đều. Cho xíu dầu vào chảo rồi cho miến vào xào, trong quá trình xào chế nước vào dần cho miến chín, xào khi gần khô thì cho hỗn hợp (3) vào.', 'https://img-global.cpcdn.com/steps/fa32de6db4e92516/400x400cq80/photo.jpg'),
('431d624b-f347-493a-a64f-cfa99f66c82a', 5, 'Đảo khô hỗn hợp (4) rồi cho lươn, hành, răm cắt rối vào đảo đều. Bày miến xào ra đĩa, cắt chỉ ớt sừng bày ra cho đẹp, rắc tiêu và hành khô lên.', 'https://img-global.cpcdn.com/steps/f78ef0b8d4716d2e/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('431d624b-f347-493a-a64f-cfa99f66c82a', 300, 15.0, 31.0, 10.0, 6.5, 57.0, 2.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('431d624b-f347-493a-a64f-cfa99f66c82a', 'món xào');

-- Món ăn: Súp lươn, khoai tây, măng tây
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', 'Súp lươn, khoai tây, măng tây', 'Trước giờ mình sợ con lươn, chưa mua về nấu mà chỉ ăn ngoài hàng, mà cũng ít ăn, mặc dù biết thịt lươn giàu dinh dưỡng. Thử thách #GlobalApron2024 tuần này giúp mình dũng cảm hơn, dám nấu món với lươn dù mình không dám làm mà phải nhờ người bán làm lươn hộ. Thế cũng đã ghi nhận cố gắng của bản thân rồi! Cảm ơn CP thật nhiều đã tạo ra sân chơi này. Bạn nấu món súp này làm khai vị cho bữa tiệc nhen! #bingo', 'https://img-global.cpcdn.com/recipes/b6e4fb3eeaeeec4a/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/17294531', 'Pham Huyen')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', '200 g lươn đã làm sạch', 'lươn đã làm sạch', '200 g', 1),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', '100 g măng tây', 'măng tây', '100 g', 1),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', '1 củ khoai tây', 'khoai tây', '1 củ', 1),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', '1 quả trứng', 'trứng', '1 quả', 1),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', '1,5 lít nước hầm xương heo hoặc gà', 'ít nước hầm xương heo hoặc gà', '1,5 l', 1),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', '2 thìa canh bột ngô', 'bột ngô', '2 thìa canh', 1),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', '5 tai nấm hương', 'tai nấm hương', '5', 1),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', 'Gừng, hành, tỏi, bột nghệ, gia vị', 'gừng, hành, tỏi, bột nghệ, gia vị', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', 1, 'Lươn ướp với hành, tỏi băm nhỏ, 1/2 thìa cf bột nghệ, 1 xíu mắm, 1 ít tiêu để 15 phút. Sau đó cắt ngang thân lươn. Hoặc bạn cắt ngang luôn rồi ướp cũng được.', 'https://img-global.cpcdn.com/steps/12b69f14a3964891/400x400cq80/photo.jpg'),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', 2, 'Khoai tây luộc chín, cắt hạt lựu; nấm hương ngâm nở cắt chỉ; măng tây chỉ lấy phần non, cắt mỏng ngang cây; gừng cắt sợi.', 'https://img-global.cpcdn.com/steps/0f7ecc115804851b/400x400cq80/photo.jpg'),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', 3, 'Phi thơm hành, tỏi cho nấm hương vào xào rồi cho nước hầm xương, khoai tây, gừng vào. Nêm gia vị hơi nhạt một chút vì lươn đã ướp gia vị.', 'https://img-global.cpcdn.com/steps/6d7268d26df53d54/400x400cq80/photo.jpg'),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', 4, 'Phi hành, tỏi cho lươn vào xào săn rồi trút vào nồi súp. Hòa bột ngô với nước lạnh cho tan rồi cho vào nồi khuấy đều, cho măng tây vào, nêm cho vừa miệng', 'https://img-global.cpcdn.com/steps/d4729e5f60d99bfc/400x400cq80/photo.jpg'),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', 5, 'Đánh tan 1 quả trứng, giơ tay cao đổ vào nồi súp, vừa đổ vừa khuấy để trứng kéo vân, khi trứng chín thì tắt bếp.', 'https://img-global.cpcdn.com/steps/31e07308cc83695b/400x400cq80/photo.jpg'),
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', 6, 'Múc súp ra bát ăn nóng để khai vị nhen!', 'https://img-global.cpcdn.com/steps/bbac042b5cecc088/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', 600, 30.0, 61.0, 24.0, 6.5, 69.5, 2.4)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('7a7f02eb-2fb2-4ce9-aeff-a0675ac95221', 'món kho');

-- Món ăn: Miến lươn
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 'Miến lươn', '#bingo #GlobalApron2024 Miến lươn là đặc sản của xứ Nghệ, cùng mình cũng tập tành vài món của tỉnh bạn xem sao nhé. (Miến, lươn)', 'https://img-global.cpcdn.com/recipes/0d96d31b187d51f4/1200x630cq80/photo.jpg', 30, 'Trung bình', '2 người', 'Ăn sáng', 'https://cookpad.com/vn/cong-thuc/17289609', 'Bếp của Quỳnh')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', '1 con lươn đồng (250 gram)', 'lươn đồng', '1 con', 1),
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', '100 gram miến dong', 'ram miến dong', '100 g', 1),
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 'Gừng, hành củ, ớt, rau răm, chanh', 'gừng, hành củ, ớt, rau răm, chanh', 'Tùy lượng', 1),
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 'Gia vị: Dầu ăn, hạt nêm, nước mắm, tiêu, ớt bột', 'gia vị', 'Dầu ăn, hạt nêm, nước mắm, tiêu, ớt bột', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 1, 'Lươn làm sạch, chà muối, chanh cho bớt nhớt, cắt khúc.', ''),
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 2, 'Luộc lươn: Cho lươn vào nồi nước, đập gừng, hành vào, muối, sôi vớt bọt, gắp lươn ra, lóc thịt lươn ướp với hành tím, ớt bột, hạt nêm, mắm, tiêu, ớt trái khoảng 30 phút, trộn đều.', 'https://img-global.cpcdn.com/steps/09883526545b70bd/400x400cq80/photo.jpg'),
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 3, 'Tao lươn: Phi thơm hành tím, cho lươn đã ướp vào tao chín, nêm gia vị vừa ăn.', 'https://img-global.cpcdn.com/steps/e3bbb5f2480da976/400x400cq80/photo.jpg'),
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 4, 'Miến ngâm khoảng 15 phút cho mềm, vớt ráo, đun sôi nước luộc lươn, cho miến vào nấu chín, lươn um cho vào nồi, sôi nêm gia vị và tắt ngay.', 'https://img-global.cpcdn.com/steps/3b8c432654df988a/400x400cq80/photo.jpg'),
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 5, 'Múc miến lươn ra tô, cho rau răm xắt, tiêu vào tô, ăn nóng.', 'https://img-global.cpcdn.com/steps/c30c9080a05fcdae/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 300, 15.0, 31.0, 10.0, 6.5, 37.8, 3.3)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 'món ngon mỗi ngày'),
('fc43a684-7bfc-4cfc-83b4-123e75e81e69', 'dễ làm');

-- Món ăn: Lươn nướng sả
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('e52acd7a-0a13-42ca-8a18-e9967d2c7769', 'Lươn nướng sả', '#bingo #globalapron2024', 'https://img-global.cpcdn.com/recipes/78811edfb4d91c6e/1200x630cq80/photo.jpg', 30, 'Trung bình', '2-4 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/17289619', 'Huyen le Tran')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('e52acd7a-0a13-42ca-8a18-e9967d2c7769', '2 con lươn', 'lươn', '2 con', 1),
('e52acd7a-0a13-42ca-8a18-e9967d2c7769', 'Sả,tỏi', 'sả,tỏi', 'Tùy lượng', 1),
('e52acd7a-0a13-42ca-8a18-e9967d2c7769', 'Dầu hào,nước tương,bột ngọt,đường', 'dầu hào,nước tương,bột ngọt,đường', 'Tùy lượng', 1),
('e52acd7a-0a13-42ca-8a18-e9967d2c7769', 'Rượu nấu ăn', 'rượu nấu ăn', 'Tùy lượng', 1),
('e52acd7a-0a13-42ca-8a18-e9967d2c7769', 'Sà lách ăn kèm', 'sà lách ăn kèm', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('e52acd7a-0a13-42ca-8a18-e9967d2c7769', 1, 'Lươn mua về đã nhờ người bán làm sẳn,cho vào túi lươn 1 chén tro bếp xốc cho lươn thấm đều rồi đem vuột cho hết nhớt đem rửa vài lần,lươn rít tay là được bỏ đầu bỏ đuôi cắt khúc rồi lóc bỏ xương,chậm khô rồi cắt xéo trên lưng những lằn xéo đan nhau.làm chén nước ướp gồm sả bằm,tỏi,dầu hào nước tương bột ngọt đường và tương ớt tùy khẩu vị mà gia giảm cho vừa.ghim lươn thành xâu đem lươn nướng cho khô ráo rồi quét nước sauce nướng lên quét 2 bề khi thấy lươn vàng xém thì lấy ra.', 'https://img-global.cpcdn.com/steps/9e403b156f16fdff/400x400cq80/photo.jpg'),
('e52acd7a-0a13-42ca-8a18-e9967d2c7769', 2, 'Lươn nướng sả ăn với cơm trắng là hết cơm chứ chẳng chơi', 'https://img-global.cpcdn.com/steps/77d61c88c5aaa313/400x400cq80/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('e52acd7a-0a13-42ca-8a18-e9967d2c7769', 400, 15.0, 25.0, 18.0, 3.0, 61.3, 2.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('e52acd7a-0a13-42ca-8a18-e9967d2c7769', 'món ngon mỗi ngày'),
('e52acd7a-0a13-42ca-8a18-e9967d2c7769', 'dễ làm');

-- Món ăn: Lươn sốt teriyaki ăn kèm khoai tây nghiền và măng tây
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('7bb383e4-635f-4daa-ab79-b8a35d7c8710', 'Lươn sốt teriyaki ăn kèm khoai tây nghiền và măng tây', '#bingo #𝑮𝒍𝒐𝒃𝒂𝒍𝑨𝒑𝒓𝒐𝒏2024', 'https://img-global.cpcdn.com/recipes/24d8d4576eff153b/1200x630cq80/photo.jpg', 30, 'Trung bình', '1 người', 'Món chính', 'https://cookpad.com/vn/cong-thuc/17288564', 'Nhà Vân')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1/2 con lươn (khoảng 150 gram)', 'lươn', '1/2 con', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1 nhánh tỏi, 1 thìa bột nghệ', 'tỏi, 1 thìa bột nghệ', '1 nhánh', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1 nhánh gừng', 'gừng', '1 nhánh', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1/2 thìa dầu hào', 'dầu hào', '1/2 thìa', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1 thìa xì dầu', 'xì dầu', '1 thìa', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1 thìa đường', 'đường', '1 thìa', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1/2 thìa giấm gạo', 'giấm gạo', '1/2 thìa', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '6 _ 10 cọng măng tây', '_ 10 cọng măng tây', '6', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1 nhánh tỏi', 'tỏi', '1 nhánh', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1 củ khoai tây', 'khoai tây', '1 củ', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '100 _150ml sữa tươi hoặc whippingcream', '_150ml sữa tươi hoặc whippingcream', '100', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1 miếng phomai con bò cười tam giác', 'phomai con bò cười tam giác', '1 miếng', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', '1 xíu tiêu và lá mùi thơm', 'xíu tiêu và lá mùi thơm', '1', 1),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', 'Dầu ăn, muối', 'dầu ăn, muối', 'Tùy lượng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', 1, 'Lươn làm sạch, lách bỏ xương, khía ngang vài đường cách nhau khoảng 2cm, khía nhẹ tránh đứt rời. Ướp với 1/2 thìa sữa chua bột nghệ, 1 nhánh tỏi, 1/2 thìa cà phê dầu hào, ít dầu ăn bóp đều. Ướp khoảng 10 phút. Sử dụng chảo chống dính, cho 2 thìa dầu ăn vào láng đáy chảo. Áp chảo chín vàng 2 mặt lươn. Có thể lươn tươi sẽ bị cong lưu ý khi cho lươn vào chảo lấy phớ hoặc muôi bằng ép lươn vào mặt chảo', ''),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', 2, 'Khi lươn chín, bỏ riêng ra đĩa, lau qua mặt chảo bỏ vụn cháy. Thêm 1 thìa dầu ăn, cho măng tây vào đảo, thêm vài hạt muối và 1 nhánh tỏi dập dập. Măng chín khá nhanh khoảng 30s_ 1 phút là được. Sử dụng chính chảo đấy thêm 1 nhánh gừng thái sợi vào đảo thơm. Cho lươn ngược trở lại chảo. Pha sốt: 1 xì dầu: 1 đường: 1/2 dấm gạo: 2 nước. Hạ nhỏ lửa đổ sốt vào rim đến khi cạn, khi rim lật mặt lươn cho ngấm đều', 'https://img-global.cpcdn.com/steps/ffd91fd58bc5fb89/400x400cq80/photo.jpg'),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', 3, 'Lúc ướp lươn thì chuẩn bị khoai tây nghiền theo công thức:', ''),
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', 4, 'Khi lươn được bỏ khoai tây nghiền lên đĩa, lươn và măng tây và thưởng thức nóng', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('7bb383e4-635f-4daa-ab79-b8a35d7c8710', 600, 30.0, 55.0, 24.0, 3.0, 63.6, 4.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('7bb383e4-635f-4daa-ab79-b8a35d7c8710', 'món kho');

-- Món ăn: Ếch xào lăn nước cốt dừa
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('064546f3-0274-4f83-98b3-ca48ee3e07ae', 'Ếch xào lăn nước cốt dừa', 'Thịt ếch thơm ngọt xào cùng sả ớt, bột cà ri vàng ươm và nước cốt dừa béo ngậy chuẩn vị miền Tây.', 'https://img-global.cpcdn.com/recipes/5144b6c3196f7c9e/1200x630cq80/photo.jpg', 35, 'Trung bình', '4 người', 'Món xào', 'https://cookpad.com/vn/cong-thuc/ech-xao-lan-cot-dua', 'Bếp Mẹ Bông')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('064546f3-0274-4f83-98b3-ca48ee3e07ae', '500g đùi ếch làm sạch', 'thịt ếch', '500g', 1),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', '150ml nước cốt dừa béo', 'nước cốt dừa', '150ml', 1),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', '3 cây sả băm nhuyễn', 'sả', '3 cây', 1),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', '1 gói bột cà ri', 'bột cà ri', '1 gói', 1),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', '1 củ hành tây cắt múi cau', 'hành tây', '1 củ', 1),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', '30g nấm mèo ngâm nở cắt sợi', 'nấm mèo', '30g', 1),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', '50g đậu phộng rang giã dập', 'đậu phộng', '50g', 1),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', '2 trái ớt sừng xắt lát', 'ớt', '2 trái', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('064546f3-0274-4f83-98b3-ca48ee3e07ae', 1, 'Ếch rửa sạch với muối và rượu trắng để khử tanh, chặt miếng vừa ăn. Ướp với 1/2 gói bột cà ri, sả băm, hạt nêm, tiêu trong 20 phút.', 'https://img-global.cpcdn.com/steps/1/photo.jpg'),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', 2, 'Phi thơm tỏi và sả băm với dầu màu điều, cho ếch vào xào săn trên lửa lớn.', 'https://img-global.cpcdn.com/steps/2/photo.jpg'),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', 3, 'Cho nấm mèo và hành tây vào đảo đều. Rưới nước cốt dừa vào đun lửa vừa cho nước sánh lại.', 'https://img-global.cpcdn.com/steps/3/photo.jpg'),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', 4, 'Múc ra đĩa, rắc đậu phộng rang và ớt lát lên trên. Dùng nóng kèm bánh mì hoặc bún tươi.', 'https://img-global.cpcdn.com/steps/4/photo.jpg');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('064546f3-0274-4f83-98b3-ca48ee3e07ae', 420, 36.0, 18.0, 22.0, 3.5, 70.0, 3.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('064546f3-0274-4f83-98b3-ca48ee3e07ae', 'món xào'),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', 'đặc sản'),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', 'thịt ếch'),
('064546f3-0274-4f83-98b3-ca48ee3e07ae', 'bột cà ri');

-- Món ăn: Lẩu ếch măng cay lá lốt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', 'Lẩu ếch măng cay lá lốt', 'Lẩu ếch nấu măng chua cay nồng kết hợp lá lốt thơm lừng, món ăn tuyệt vời cho những ngày se lạnh.', 'https://img-global.cpcdn.com/recipes/7b4f53589b30c4a2/1200x630cq80/photo.jpg', 45, 'Trung bình', '4-6 người', 'Lẩu', 'https://cookpad.com/vn/cong-thuc/lau-ech-mang-cay', 'Hà Nội Quán')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', '800g ếch làm sạch', 'thịt ếch', '800g', 1),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', '400g măng củ hoặc măng lá ngâm chua', 'măng chua', '400g', 1),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', '1 bó lá lốt rửa sạch cắt khúc', 'lá lốt', '1 bó', 1),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', '1 bó lá tía tô', 'tía tô', '1 bó', 1),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', '4 cây sả đập dập', 'sả', '4 cây', 1),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', '3 trái ớt hiểm cay', 'ớt', '3 trái', 1),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', '3 bìa đậu hũ cắt khối chiên vàng', 'đậu phụ', '3 bìa', 1),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', '500g bún tươi ăn kèm', 'bún tươi', '500g', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', 1, 'Ếch tẩm chút bột bắp rồi chiên sơ cho săn và vàng đều mặt.', ''),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', 2, 'Măng chua luộc 2 lần cho sạch độc tố, vắt ráo rồi xào thơm với tỏi, ớt và sả.', ''),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', 3, 'Cho ếch vào xào cùng măng cho thấm đượm gia vị, rắc chút lá lốt vào đảo sơ.', ''),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', 4, 'Nấu nước dùng từ xương ống hoặc nước dừa, nêm giấm bỗng chua thanh. Khi ăn nhúng ếch xào măng, đậu hũ và lá lốt, tía tô vào nồi lẩu sôi sùng sục.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', 480, 42.0, 30.0, 16.0, 4.0, 110.0, 4.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', 'lẩu'),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', 'măng chua'),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', 'lá lốt'),
('dc7334f0-6959-44fd-b74d-1b9dfdc57adb', 'món cay');

-- Món ăn: Lươn om chuối đậu thịt ba chỉ
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('fab57de7-1024-493c-9a93-5072872b9b00', 'Lươn om chuối đậu thịt ba chỉ', 'Món ăn kinh điển đất Bắc với thịt lươn mềm thơm, chuối xanh bùi dẻo, thịt ba chỉ béo ngậy và nước cốt nghệ mẻ vàng sánh.', 'https://img-global.cpcdn.com/recipes/f989912068e1ab66/1200x630cq80/photo.jpg', 45, 'Khó', '4 người', 'Món kho/om', 'https://cookpad.com/vn/cong-thuc/luon-om-chuoi-dau', 'Bếp Bắc Bộ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('fab57de7-1024-493c-9a93-5072872b9b00', '500g lươn đồng làm sạch tuốt nhớt', 'lươn', '500g', 1),
('fab57de7-1024-493c-9a93-5072872b9b00', '4 quả chuối tiêu xanh tước vỏ ngâm nước muối', 'chuối xanh', '4 quả', 1),
('fab57de7-1024-493c-9a93-5072872b9b00', '3 bìa đậu hũ cắt khối rán vàng', 'đậu phụ', '3 bìa', 1),
('fab57de7-1024-493c-9a93-5072872b9b00', '200g thịt ba chỉ heo xắt miếng', 'thịt ba chỉ', '200g', 1),
('fab57de7-1024-493c-9a93-5072872b9b00', '1 nắm lá lốt xắt nhỏ', 'lá lốt', '1 nắm', 1),
('fab57de7-1024-493c-9a93-5072872b9b00', '1 nắm lá tía tô xắt nhỏ', 'tía tô', '1 nắm', 1),
('fab57de7-1024-493c-9a93-5072872b9b00', '1 củ nghệ tươi giã lấy nước cốt', 'nghệ', '1 củ', 1),
('fab57de7-1024-493c-9a93-5072872b9b00', '3 muỗng canh cơm mẻ lọc lấy nước chua', 'cơm mẻ', '3 muỗng', 1),
('fab57de7-1024-493c-9a93-5072872b9b00', '1 muỗng cà phê mắm tôm ngon', 'mắm tôm', '1 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('fab57de7-1024-493c-9a93-5072872b9b00', 1, 'Lươn cắt khúc 3-4cm, ướp với nước nghệ, mẻ, mắm tôm, hạt nêm, tiêu 15 phút.', ''),
('fab57de7-1024-493c-9a93-5072872b9b00', 2, 'Thịt ba chỉ đảo cháy cạnh trong nồi, cho lươn vào xào săn rồi trút ra đĩa.', ''),
('fab57de7-1024-493c-9a93-5072872b9b00', 3, 'Cho chuối xanh vào xào, châm nước xăm xắp đun sôi. Thêm đậu rán và lươn vào om lửa nhỏ 15 phút cho chuối mềm nhừ.', ''),
('fab57de7-1024-493c-9a93-5072872b9b00', 4, 'Lấy vài miếng chuối nghiền nhuyễn tạo độ sánh cho nước om. Tắt bếp, rắc lá lốt, tía tô, hành lá đảo đều.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('fab57de7-1024-493c-9a93-5072872b9b00', 460, 38.0, 26.0, 20.0, 4.2, 120.0, 5.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('fab57de7-1024-493c-9a93-5072872b9b00', 'món om'),
('fab57de7-1024-493c-9a93-5072872b9b00', 'lươn'),
('fab57de7-1024-493c-9a93-5072872b9b00', 'chuối xanh'),
('fab57de7-1024-493c-9a93-5072872b9b00', 'mẻ nghệ');

-- Món ăn: Miến lươn xào rau răm giòn ngon
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('474ca81d-19a9-438f-bc44-311a9ea1c09a', 'Miến lươn xào rau răm giòn ngon', 'Miến dong dai mềm kết hợp lươn xào đậm đà, mộc nhĩ nấm hương và rau răm thơm nồng đặc trưng Nghệ An.', 'https://img-global.cpcdn.com/recipes/42dc081a95e2df89/1200x630cq80/photo.jpg', 30, 'Trung bình', '3 người', 'Món xào', 'https://cookpad.com/vn/cong-thuc/mien-luon-xao', 'Lê Trang')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('474ca81d-19a9-438f-bc44-311a9ea1c09a', '300g lươn đã lọc xương cắt sợi', 'lươn', '300g', 1),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', '200g miến dong ngâm mềm cắt khúc', 'miến', '200g', 1),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', '3 tai nấm mèo ngâm nở thái chỉ', 'mộc nhĩ', '3 tai', 1),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', '5 tai nấm hương thái mỏng', 'nấm hương', '5 cái', 1),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', '1/2 củ cà rốt bào sợi', 'cà rốt', '1/2 củ', 1),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', '1 nắm rau răm cắt nhỏ', 'rau răm', '1 nắm', 1),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', '3 củ hành tím băm phi thơm', 'hành tím', '3 củ', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('474ca81d-19a9-438f-bc44-311a9ea1c09a', 1, 'Lươn tẩm gia vị và xào lăn cho thật săn và đậm đà, trút riêng ra đĩa.', ''),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', 2, 'Phi thơm hành, xào mộc nhĩ, nấm hương và cà rốt vừa chín tới.', ''),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', 3, 'Cho miến dong vào xào nhanh tay trên lửa lớn, rưới ít nước tương và dầu hào cho ngấm.', ''),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', 4, 'Trút thịt lươn và rau răm vào đảo đều trong 1 phút rồi bày ra đĩa, rắc tiêu thơm.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('474ca81d-19a9-438f-bc44-311a9ea1c09a', 390, 28.0, 48.0, 10.0, 3.0, 65.0, 3.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('474ca81d-19a9-438f-bc44-311a9ea1c09a', 'món xào'),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', 'miến dong'),
('474ca81d-19a9-438f-bc44-311a9ea1c09a', 'rau răm');

-- Món ăn: Ốc xào sả ớt lá lốt giòn cay
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('17995f27-b6ec-423f-9f64-641d0631b6f4', 'Ốc xào sả ớt lá lốt giòn cay', 'Thịt ốc bươu giòn sần sật xào cùng sả ớt thơm cay nồng nặc và lá lốt bùi thơm.', 'https://img-global.cpcdn.com/recipes/5d540236a2ba270a/1200x630cq80/photo.jpg', 25, 'Dễ', '3-4 người', 'Món xào', 'https://cookpad.com/vn/cong-thuc/oc-xao-sa-ot-la-lot', 'Hương Ốc')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('17995f27-b6ec-423f-9f64-641d0631b6f4', '500g ruột ốc bươu hoặc ốc nhồi bóp muối sạch', 'ốc', '500g', 1),
('17995f27-b6ec-423f-9f64-641d0631b6f4', '4 cây sả xắt lát mỏng', 'sả', '4 cây', 1),
('17995f27-b6ec-423f-9f64-641d0631b6f4', '2 quả ớt sừng và ớt cay', 'ớt', '2 quả', 1),
('17995f27-b6ec-423f-9f64-641d0631b6f4', '10 lá lốt rửa sạch thái sợi to', 'lá lốt', '10 lá', 1),
('17995f27-b6ec-423f-9f64-641d0631b6f4', '1 củ tỏi băm nhuyễn', 'tỏi', '1 củ', 1),
('17995f27-b6ec-423f-9f64-641d0631b6f4', '1 muỗng canh dầu hào', 'dầu hào', '1 muỗng', 1),
('17995f27-b6ec-423f-9f64-641d0631b6f4', '1 muỗng canh nước mắm', 'nước mắm', '1 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('17995f27-b6ec-423f-9f64-641d0631b6f4', 1, 'Ốc bóp kỹ với muối và giấm cho hết nhớt, rửa sạch rồi chần sơ qua nước sôi có gừng đập dập.', ''),
('17995f27-b6ec-423f-9f64-641d0631b6f4', 2, 'Phi thơm tỏi và sả lát với dầu ăn cho dậy mùi thơm vàng.', ''),
('17995f27-b6ec-423f-9f64-641d0631b6f4', 3, 'Cho ốc vào xào thật nhanh tay trên lửa cực lớn trong 2-3 phút, nêm dầu hào, nước mắm, tiêu.', ''),
('17995f27-b6ec-423f-9f64-641d0631b6f4', 4, 'Trút lá lốt và ớt lát vào đảo nhanh 30 giây rồi tắt bếp để giữ độ giòn ngọt của ốc.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('17995f27-b6ec-423f-9f64-641d0631b6f4', 280, 32.0, 12.0, 8.0, 2.0, 180.0, 6.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('17995f27-b6ec-423f-9f64-641d0631b6f4', 'món xào'),
('17995f27-b6ec-423f-9f64-641d0631b6f4', 'ốc'),
('17995f27-b6ec-423f-9f64-641d0631b6f4', 'lá lốt'),
('17995f27-b6ec-423f-9f64-641d0631b6f4', 'sả ớt');

-- Món ăn: Chả ốc cuốn lá lốt nướng than
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('b3c93e19-5179-466d-8cff-295cbb45d71d', 'Chả ốc cuốn lá lốt nướng than', 'Thịt ốc giòn sần sật băm nhuyễn trộn cùng giò sống và thịt xay, cuốn trong lá lốt thơm lừng rán giòn.', 'https://img-global.cpcdn.com/recipes/5e81d77a08bda6eb/1200x630cq80/photo.jpg', 35, 'Trung bình', '4 người', 'Món chiên/nướng', 'https://cookpad.com/vn/cong-thuc/cha-oc-la-lot', 'Bếp Cô Mai')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('b3c93e19-5179-466d-8cff-295cbb45d71d', '300g thịt ốc nhồi băm nhỏ hạt lựu', 'ốc', '300g', 1),
('b3c93e19-5179-466d-8cff-295cbb45d71d', '200g thịt nạc vai xay nhuyễn', 'thịt heo', '200g', 1),
('b3c93e19-5179-466d-8cff-295cbb45d71d', '100g giò sống tạo độ kết dính', 'giò sống', '100g', 1),
('b3c93e19-5179-466d-8cff-295cbb45d71d', '20 lá lốt bản to nguyên vẹn', 'lá lốt', '20 lá', 1),
('b3c93e19-5179-466d-8cff-295cbb45d71d', '2 tai nấm mèo ngâm nở băm nhỏ', 'mộc nhĩ', '2 tai', 1),
('b3c93e19-5179-466d-8cff-295cbb45d71d', '2 cây sả băm nhuyễn', 'sả', '2 cây', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('b3c93e19-5179-466d-8cff-295cbb45d71d', 1, 'Trộn đều ốc băm, thịt xay, giò sống, mộc nhĩ, sả băm, hạt tiêu, nước mắm ngon.', ''),
('b3c93e19-5179-466d-8cff-295cbb45d71d', 2, 'Trải mặt trái lá lốt ra thớt, múc một lượng nhân vừa đủ vào giữa và cuộn tròn mép lại.', ''),
('b3c93e19-5179-466d-8cff-295cbb45d71d', 3, 'Rán chả trên chảo dầu lửa vừa hoặc nướng nồi chiên không dầu 180 độ trong 12 phút.', ''),
('b3c93e19-5179-466d-8cff-295cbb45d71d', 4, 'Ăn kèm bún tươi, rau sống và nước mắm chua ngọt pha tỏi ớt gừng.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('b3c93e19-5179-466d-8cff-295cbb45d71d', 350, 34.0, 8.0, 19.0, 2.5, 140.0, 5.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('b3c93e19-5179-466d-8cff-295cbb45d71d', 'chả cuốn'),
('b3c93e19-5179-466d-8cff-295cbb45d71d', 'lá lốt'),
('b3c93e19-5179-466d-8cff-295cbb45d71d', 'ốc'),
('b3c93e19-5179-466d-8cff-295cbb45d71d', 'món rán');

-- Món ăn: Hàu nướng mỡ hành đậu phộng
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('c832e9b6-27a6-4c86-aa00-d7966ca86f45', 'Hàu nướng mỡ hành đậu phộng', 'Hàu sữa tươi béo ngậy nướng thơm lừng cùng mỡ hành xanh mướt và đậu phộng rang giòn tan.', 'https://img-global.cpcdn.com/recipes/209c13b2c2d9bb4e/1200x630cq80/photo.jpg', 20, 'Dễ', '3-4 người', 'Món nướng', 'https://cookpad.com/vn/cong-thuc/hau-nuong-mo-hanh', 'Hải Sản Phố')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', '1 kg hàu sữa tươi sống tách nửa vỏ', 'hàu', '1 kg', 1),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', '1 bó hành lá xắt nhỏ', 'hành', '1 bó', 1),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', '50g đậu phộng rang giã dập', 'đậu phộng', '50g', 1),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', '4 muỗng canh dầu ăn hoặc mỡ heo', 'dầu ăn', '4 muỗng', 1),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', '3 củ hành tím phi vàng giòn', 'hành tím', '3 củ', 1),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', '1 quả ớt băm nhuyễn', 'ớt', '1 quả', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', 1, 'Đun nóng dầu/mỡ heo rồi rưới trực tiếp vào chén hành lá xắt nhỏ, nêm chút muối đường đảo đều để giữ màu xanh.', ''),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', 2, 'Rửa sạch hàu, xếp hàu lên vỉ nướng than hoặc khay nướng nồi chiên không dầu.', ''),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', 3, 'Rưới đều một muỗng mỡ hành lên từng con hàu, nướng ở 200°C trong 6-8 phút cho hàu chín tới.', ''),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', 4, 'Rắc hành phi và đậu phộng rang lên trên, vắt chút nước cốt tắc và chấm muối tiêu chanh.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('c832e9b6-27a6-4c86-aa00-d7966ca86f45', 310, 22.0, 14.0, 18.0, 1.5, 90.0, 7.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', 'món nướng'),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', 'hàu sữa'),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', 'mỡ hành'),
('c832e9b6-27a6-4c86-aa00-d7966ca86f45', 'hải sản');

-- Món ăn: Canh ngao nấu chua dứa cà chua
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', 'Canh ngao nấu chua dứa cà chua', 'Nước canh ngao ngọt thanh tự nhiên kết hợp vị chua mát của dứa, cà chua và hương thơm của rau răm thì là.', 'https://img-global.cpcdn.com/recipes/7b2e811c0c329dd4/1200x630cq80/photo.jpg', 25, 'Dễ', '4 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/canh-ngao-nau-chua', 'Thuỳ Dung')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', '1 kg ngao trắng hoặc nghêu ngâm sạch cát', 'ngao', '1 kg', 1),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', '1/2 quả dứa (thơm) xắt lát tam giác', 'dứa', '1/2 quả', 1),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', '2 quả cà chua bổ múi cau', 'cà chua', '2 quả', 1),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', '2 quả sấu hoặc 1 muỗng me chua', 'sấu', '2 quả', 1),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', '1 nắm rau răm và hành lá cắt nhỏ', 'rau răm', '1 nắm', 1),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', '1 nhánh gừng đập dập', 'gừng', '1 nhánh', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', 1, 'Ngao luộc với ít nước và gừng đến khi mở miệng. Vớt ngao ra tách lấy ruột, chắt nước luộc trong để làm nước canh.', ''),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', 2, 'Phi thơm hành tím, xào cà chua cho mềm tạo màu đẹp rồi cho ruột ngao vào xào sơ với chút nước mắm.', ''),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', 3, 'Đổ nước luộc ngao vào nồi đun sôi, thả dứa và sấu vào nấu 5 phút cho tiết vị chua ngọt.', ''),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', 4, 'Thả ruột ngao vào đun sôi lại, dầm sấu cho chua vừa vị rồi rắc rau răm, hành lá và tắt bếp.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', 180, 18.0, 16.0, 3.5, 2.2, 85.0, 4.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', 'món canh'),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', 'ngao'),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', 'dứa'),
('2b4cd606-fc51-4a5b-ae5a-5f5ff2adbff8', 'canh chua');

-- Món ăn: Bạch tuộc nướng sa tế cay giòn
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('3a17cb5a-cf12-4591-a48a-d3c640efab20', 'Bạch tuộc nướng sa tế cay giòn', 'Bạch tuộc tươi giòn sần sật ướp sốt sa tế ớt cay nồng, nướng cháy xém cạnh thơm phức hấp dẫn.', 'https://img-global.cpcdn.com/recipes/5c77a942df39430c/1200x630cq80/photo.jpg', 25, 'Dễ', '3-4 người', 'Món nướng', 'https://cookpad.com/vn/cong-thuc/bach-tuoc-nuong-sa-te', 'Chef Hải Nam')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('3a17cb5a-cf12-4591-a48a-d3c640efab20', '600g bạch tuộc tươi làm sạch bóp muối', 'bạch tuộc', '600g', 1),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', '2 muỗng canh ớt sa tế tôm cay', 'sa tế', '2 muỗng', 1),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', '1 muỗng canh dầu hào', 'dầu hào', '1 muỗng', 1),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', '1 muỗng cà phê mật ong tạo màu bóng', 'mật ong', '1 muỗng', 1),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', '2 cây sả băm nhỏ', 'sả', '2 cây', 1),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', '1 củ tỏi băm', 'tỏi', '1 củ', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('3a17cb5a-cf12-4591-a48a-d3c640efab20', 1, 'Bạch tuộc rửa sạch, để ráo. Trộn đều sốt sa tế, dầu hào, mật ong, sả, tỏi băm.', ''),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', 2, 'Ướp bạch tuộc với hỗn hợp sốt trong 20 phút cho thấm sâu.', ''),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', 3, 'Nướng trên than hoa hoặc nồi chiên không dầu ở 190°C trong 10-12 phút đến khi giòn thơm.', ''),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', 4, 'Cắt miếng vừa ăn, dùng kèm dưa leo, rau răm và muối ớt xanh.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('3a17cb5a-cf12-4591-a48a-d3c640efab20', 320, 35.0, 10.0, 14.0, 1.0, 60.0, 6.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('3a17cb5a-cf12-4591-a48a-d3c640efab20', 'món nướng'),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', 'bạch tuộc'),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', 'sa tế'),
('3a17cb5a-cf12-4591-a48a-d3c640efab20', 'hải sản');

-- Món ăn: Vịt om sấu khoai sọ chuẩn vị Hà Nội
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('3b3c21ea-efd2-4274-aed1-4199aed51d77', 'Vịt om sấu khoai sọ chuẩn vị Hà Nội', 'Thịt vịt béo ngậy được om mềm với quả sấu chua thanh và khoai sọ dẻo bùi tạo nên hương vị đặc trưng mùa thu Bắc Bộ.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee18e2/1200x630cq80/photo.jpg', 45, 'Trung bình', '4-5 người', 'Món kho/om', 'https://cookpad.com/vn/cong-thuc/vit-om-sau', 'Hà Nội Foodie')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('3b3c21ea-efd2-4274-aed1-4199aed51d77', '1 kg thịt vịt cỏ rửa sạch bằng rượu gừng', 'vịt', '1 kg', 1),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', '8 quả sấu xanh cạo vỏ', 'sấu', '8 quả', 1),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', '400g khoai sọ gọt vỏ cắt miếng', 'khoai sọ', '400g', 1),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', '1 bó rau muống nhặt ngọn non ăn kèm', 'rau muống', '1 bó', 1),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', '1 củ gừng đập dập', 'gừng', '1 củ', 1),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', '3 cây sả băm', 'sả', '3 cây', 1),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', '1 quả nước dừa tươi ngọt thanh', 'nước dừa tươi', '1 quả', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('3b3c21ea-efd2-4274-aed1-4199aed51d77', 1, 'Vịt chặt miếng vừa ăn, ướp với gừng, sả, hành tím, nước mắm, hạt nêm trong 20 phút.', ''),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', 2, 'Phi thơm hành tỏi sả, cho thịt vịt vào xào săn trên lửa lớn cho ra bớt mỡ thừa.', ''),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', 3, 'Đổ nước dừa và thêm nước lọc xăm xắp, thả quả sấu vào đun sôi rồi hạ nhỏ lửa om 20 phút.', ''),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', 4, 'Thêm khoai sọ vào om tiếp 15 phút cho khoai chín mềm dẻo. Dầm sấu nêm nếm lại, rắc mùi tàu (ngò gai) và tắt bếp.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('3b3c21ea-efd2-4274-aed1-4199aed51d77', 520, 38.0, 35.0, 24.0, 4.5, 75.0, 4.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('3b3c21ea-efd2-4274-aed1-4199aed51d77', 'món om'),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', 'vịt'),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', 'quả sấu'),
('3b3c21ea-efd2-4274-aed1-4199aed51d77', 'khoai sọ');

-- Món ăn: Vịt nấu chao miền Tây thơm nức
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', 'Vịt nấu chao miền Tây thơm nức', 'Vịt nấu chao đỏ béo ngậy, khoai môn dẻo mềm cùng rau muống nhúng nước dùng thơm lừng hương vị Nam Bộ.', 'https://img-global.cpcdn.com/recipes/7b43b18c5e93df12/1200x630cq80/photo.jpg', 50, 'Trung bình', '4-6 người', 'Lẩu', 'https://cookpad.com/vn/cong-thuc/vit-nau-chao', 'Má Ba Cần Thơ')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', '1 kg thịt vịt xiêm rửa sạch', 'vịt', '1 kg', 1),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', '1 hũ chao trắng và chao đỏ tán nhuyễn', 'chao', '1 hũ', 1),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', '400g khoai môn cao cắt khối chiên sơ', 'khoai môn', '400g', 1),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', '500ml nước dừa tươi xiêm', 'nước dừa', '500ml', 1),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', '1 bó rau muống xanh giòn', 'rau muống', '1 bó', 1),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', '4 cây sả đập dập băm nhỏ', 'sả', '4 cây', 1),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', '500g bún tươi', 'bún', '500g', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', 1, 'Thịt vịt chặt miếng, ướp với 4 viên chao đỏ + 2 viên chao trắng, sả băm, tỏi ớt, đường trong 30 phút.', ''),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', 2, 'Phi thơm tỏi sả, cho vịt vào xào thật săn và ngấm đều gia vị chao.', ''),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', 3, 'Đổ nước dừa tươi vào đun sôi, hạ nhỏ lửa hầm khoảng 25 phút đến khi thịt vịt mềm.', ''),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', 4, 'Cho khoai môn chiên vào nấu thêm 10 phút. Làm nước chấm chao pha chút đường, chanh, ớt băm để chấm kèm.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', 580, 40.0, 42.0, 28.0, 5.0, 95.0, 4.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', 'vịt nấu chao'),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', 'chao'),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', 'khoai môn'),
('dd194c31-a5c0-4dd0-a3e6-e75e0f2dfe46', 'ẩm thực miền Tây');

-- Món ăn: Dê hấp tía tô sả gừng chấm chao
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', 'Dê hấp tía tô sả gừng chấm chao', 'Thịt dê núi tươi mềm ngọt tự nhiên hấp cùng lá tía tô thơm mát, sả gừng giữ nguyên độ ngọt không hề có mùi gây.', 'https://img-global.cpcdn.com/recipes/5d1f8872eb0f10c3/1200x630cq80/photo.jpg', 25, 'Dễ', '4 người', 'Món hấp', 'https://cookpad.com/vn/cong-thuc/de-hap-tia-to', 'Dê Núi Ninh Bình')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', '500g thịt đùi dê hoặc thịt dê ba chỉ có da mỏng', 'dê', '500g', 1),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', '2 bó lá tía tô tươi non', 'tía tô', '2 bó', 1),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', '5 cây sả đập dập cắt khúc', 'sả', '5 cây', 1),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', '1 củ gừng tươi thái chỉ', 'gừng', '1 củ', 1),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', '3 viên chao ngon pha chấm kèm', 'chao', '3 viên', 1),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', '2 quả ớt sừng', 'ớt', '2 quả', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', 1, 'Thịt dê thái mỏng vừa ăn, ướp sơ với chút hạt nêm, tiêu và 1/2 gừng thái chỉ.', ''),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', 2, 'Xếp một lớp sả đập dập và lá tía tô dưới đáy xửng hấp.', ''),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', 3, 'Trải đều thịt dê lên trên, phủ thêm một lớp lá tía tô và gừng chỉ lên mặt thịt.', ''),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', 4, 'Hấp cách thủy trên lửa lớn trong 8-10 phút cho thịt vừa chín tới để giữ độ mềm ngọt. Chấm cùng sốt chao hoặc tương gừng.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', 360, 42.0, 4.0, 18.0, 2.0, 60.0, 5.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', 'món hấp'),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', 'thịt dê'),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', 'tía tô'),
('ac4d4b5e-567c-4b00-b839-829e4b6b09a4', 'đặc sản');

-- Món ăn: Bò cuộn lá lốt nướng than hoa
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('fb73089d-0a5a-46e1-85e6-088d8a199924', 'Bò cuộn lá lốt nướng than hoa', 'Thịt bò tẩm ướp sả thơm được cuốn trong lá lốt xanh mướt nướng xèo xèo trên than hồng, chấm mắm nêm đậm đà.', 'https://img-global.cpcdn.com/recipes/7b43b18c5e93df14/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Món nướng', 'https://cookpad.com/vn/cong-thuc/bo-cuon-la-lot', 'Sài Gòn Phố')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('fb73089d-0a5a-46e1-85e6-088d8a199924', '400g thịt bò băm nhuyễn', 'thịt bò', '400g', 1),
('fb73089d-0a5a-46e1-85e6-088d8a199924', '100g mỡ heo băm nhỏ giúp chả mềm mọng', 'thịt heo', '100g', 1),
('fb73089d-0a5a-46e1-85e6-088d8a199924', '30 lá lốt rửa sạch để ráo', 'lá lốt', '30 lá', 1),
('fb73089d-0a5a-46e1-85e6-088d8a199924', '3 cây sả băm nhuyễn', 'sả', '3 cây', 1),
('fb73089d-0a5a-46e1-85e6-088d8a199924', '50g đậu phộng rang giã dập', 'đậu phộng', '50g', 1),
('fb73089d-0a5a-46e1-85e6-088d8a199924', '1 xấp bánh tráng và rau sống, bún cuốn kèm', 'bánh tráng', '1 xấp', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('fb73089d-0a5a-46e1-85e6-088d8a199924', 1, 'Trộn thịt bò, mỡ heo, sả băm, tỏi băm, 1 muỗng dầu hào, tiêu, hạt nêm ướp 15 phút.', ''),
('fb73089d-0a5a-46e1-85e6-088d8a199924', 2, 'Đặt mặt sẫm của lá lốt úp xuống, cho một thìa thịt bò vào giữa và cuộn tròn chặt tay.', ''),
('fb73089d-0a5a-46e1-85e6-088d8a199924', 3, 'Xiên chả vào que nướng hoặc xếp vào vỉ, quét chút dầu ăn nướng 8-10 phút đến khi lá lốt dậy mùi thơm nức.', ''),
('fb73089d-0a5a-46e1-85e6-088d8a199924', 4, 'Bày ra đĩa rắc mỡ hành và đậu phộng rang, cuốn cùng bánh tráng, rau rừng chấm mắm nêm chua ngọt.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('fb73089d-0a5a-46e1-85e6-088d8a199924', 420, 38.0, 12.0, 24.0, 3.0, 120.0, 5.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('fb73089d-0a5a-46e1-85e6-088d8a199924', 'bò lá lốt'),
('fb73089d-0a5a-46e1-85e6-088d8a199924', 'món nướng'),
('fb73089d-0a5a-46e1-85e6-088d8a199924', 'lá lốt'),
('fb73089d-0a5a-46e1-85e6-088d8a199924', 'mắm nêm');

-- Món ăn: Bắp bò ngâm mắm chua ngọt tiêu xanh
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('89a36551-43e4-4c6a-8e7c-6e464cc919c0', 'Bắp bò ngâm mắm chua ngọt tiêu xanh', 'Bắp bò hoa luộc thơm ngâm trong nước mắm cốt pha đường phèn, giấm gạo và ớt hiểm, ăn giòn sần sật đậm đà.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee18e9/1200x630cq80/photo.jpg', 40, 'Trung bình', '6 người', 'Món khai vị/ngâm', 'https://cookpad.com/vn/cong-thuc/bap-bo-ngam-mam', 'Món Ngon Mẹ Nấu')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', '1 kg bắp bò hoa hoặc bắp lõi rùa', 'thịt bò', '1 kg', 1),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', '300ml nước mắm truyền thống ngon', 'nước mắm', '300ml', 1),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', '3 nhánh tiêu xanh tươi', 'tiêu', '3 nhánh', 1),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', '2 củ tỏi cắt lát', 'tỏi', '2 củ', 1),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', '5 quả ớt hiểm đỏ', 'ớt', '5 quả', 1),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', '1 củ gừng và hoa hồi, quế luộc bắp bò', 'gừng', '1 củ', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', 1, 'Bắp bò cuộn chặt chỉ, luộc cùng gừng, hoa hồi, quế khoảng 35 phút cho bắp bò chín tới, vớt ra ngâm nước đá rồi cho vào ngăn mát tủ lạnh cho săn chắc.', ''),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', 2, 'Nấu hỗn hợp nước ngâm gồm: 300ml nước mắm, 250g đường phèn, 150ml giấm gạo, 100ml nước lọc đun sôi để thật nguội.', ''),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', 3, 'Cho bắp bò, tỏi lát, ớt, tiêu xanh vào hũ thủy tinh tiệt trùng, rót nước mắm nguội ngập bắp bò.', ''),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', 4, 'Ngâm 2-3 ngày là có thể lấy ra thái lát mỏng tang, gân bò giòn sần sật tuyệt ngon.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('89a36551-43e4-4c6a-8e7c-6e464cc919c0', 340, 44.0, 15.0, 11.0, 0.8, 40.0, 4.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', 'bắp bò'),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', 'món ngâm'),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', 'tiêu xanh'),
('89a36551-43e4-4c6a-8e7c-6e464cc919c0', 'đặc sản Tết');

-- Món ăn: Gân bò hầm dưa chua sốt cà chua
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('626d6881-8882-4a25-9281-df66c3ea12c8', 'Gân bò hầm dưa chua sốt cà chua', 'Gân bò giòn dẻo hầm cùng dưa cải chua giòn sần sật, cà chua và thì là tạo vị chua thanh thơm nức mũi.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee18f1/1200x630cq80/photo.jpg', 45, 'Trung bình', '4 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/gan-bo-ham-dua-chua', 'Thu Hằng')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('626d6881-8882-4a25-9281-df66c3ea12c8', '500g gân bò trong hoặc gân bò y', 'thịt bò', '500g', 1),
('626d6881-8882-4a25-9281-df66c3ea12c8', '300g dưa cải muối chua', 'dưa chua', '300g', 1),
('626d6881-8882-4a25-9281-df66c3ea12c8', '2 quả cà chua chín đỏ', 'cà chua', '2 quả', 1),
('626d6881-8882-4a25-9281-df66c3ea12c8', '1 nắm thì là và hành hoa cắt khúc', 'thì là', '1 nắm', 1),
('626d6881-8882-4a25-9281-df66c3ea12c8', '1 củ gừng đập dập', 'gừng', '1 củ', 1),
('626d6881-8882-4a25-9281-df66c3ea12c8', '1 củ tỏi phi thơm', 'tỏi', '1 củ', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('626d6881-8882-4a25-9281-df66c3ea12c8', 1, 'Gân bò luộc sơ với gừng cho sạch, chặt miếng vuông vừa ăn rồi xào thơm với tỏi và gia vị.', ''),
('626d6881-8882-4a25-9281-df66c3ea12c8', 2, 'Ninh gân bò trong nồi áp suất 20 phút cho gân bò đạt độ mềm dẻo nhưng vẫn giữ độ giòn sần sật.', ''),
('626d6881-8882-4a25-9281-df66c3ea12c8', 3, 'Phi thơm hành, xào cà chua và dưa chua cho ngấm gia vị rồi trút vào nồi nước hầm gân bò.', ''),
('626d6881-8882-4a25-9281-df66c3ea12c8', 4, 'Đun sôi thêm 5 phút cho dưa tiết vị chua dịu, rắc hành hoa, thì là rồi múc ra bát dùng nóng.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('626d6881-8882-4a25-9281-df66c3ea12c8', 330, 36.0, 14.0, 12.0, 3.0, 65.0, 3.9)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('626d6881-8882-4a25-9281-df66c3ea12c8', 'gân bò'),
('626d6881-8882-4a25-9281-df66c3ea12c8', 'dưa chua'),
('626d6881-8882-4a25-9281-df66c3ea12c8', 'món canh'),
('626d6881-8882-4a25-9281-df66c3ea12c8', 'thì là');

-- Món ăn: Canh khổ qua nhồi thịt băm thanh nhiệt
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('84860fbb-1811-48cf-9231-9f7073213d1c', 'Canh khổ qua nhồi thịt băm thanh nhiệt', 'Món canh truyền thống mang ý nghĩa xua tan mọi khổ ải, vị đắng dịu thanh mát của khổ qua hòa quyện nhân thịt ngọt đậm đà.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee18f4/1200x630cq80/photo.jpg', 35, 'Dễ', '4 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/canh-kho-qua-nhoi-thit', 'Bếp Miền Nam')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('84860fbb-1811-48cf-9231-9f7073213d1c', '3 quả mướp đắng (khổ qua) bỏ ruột', 'khổ qua', '3 quả', 1),
('84860fbb-1811-48cf-9231-9f7073213d1c', '250g thịt heo xay nhuyễn', 'thịt heo', '250g', 1),
('84860fbb-1811-48cf-9231-9f7073213d1c', '3 tai nấm mèo băm nhỏ', 'mộc nhĩ', '3 tai', 1),
('84860fbb-1811-48cf-9231-9f7073213d1c', '30g miến dong ngâm mềm cắt vụn', 'miến', '30g', 1),
('84860fbb-1811-48cf-9231-9f7073213d1c', '1 bó hành lá chần qua nước sôi buộc khúc', 'hành', '1 bó', 1),
('84860fbb-1811-48cf-9231-9f7073213d1c', '1 muỗng cà phê hạt tiêu thơm', 'tiêu', '1 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('84860fbb-1811-48cf-9231-9f7073213d1c', 1, 'Khổ qua cắt khúc 4-5cm, dùng thìa móc sạch ruột trắng bên trong để giảm bớt độ đắng.', ''),
('84860fbb-1811-48cf-9231-9f7073213d1c', 2, 'Trộn thịt xay, mộc nhĩ, miến dong, hành tím băm, tiêu, hạt nêm rồi nhồi chặt vào từng khúc khổ qua.', ''),
('84860fbb-1811-48cf-9231-9f7073213d1c', 3, 'Đun sôi 1.2 lít nước dùng xương hoặc nước lọc, thả từng khúc khổ qua vào hớt bọt liên tục.', ''),
('84860fbb-1811-48cf-9231-9f7073213d1c', 4, 'Hạ nhỏ lửa nấu 20-25 phút đến khi khổ qua chín mềm chuyển màu xanh thẫm, nêm vừa ăn, rắc ngò rí.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('84860fbb-1811-48cf-9231-9f7073213d1c', 240, 24.0, 12.0, 10.0, 3.8, 50.0, 2.5)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('84860fbb-1811-48cf-9231-9f7073213d1c', 'khổ qua'),
('84860fbb-1811-48cf-9231-9f7073213d1c', 'mướp đắng'),
('84860fbb-1811-48cf-9231-9f7073213d1c', 'canh nhồi thịt'),
('84860fbb-1811-48cf-9231-9f7073213d1c', 'thanh nhiệt');

-- Món ăn: Khổ qua xào trứng gà bùi thơm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('6d23239c-6e49-4062-9541-dfdd39d3bd54', 'Khổ qua xào trứng gà bùi thơm', 'Khổ qua thái mỏng giòn sần sật xào cùng trứng gà vàng ươm, món ăn dân dã giải nhiệt nhanh chóng chỉ trong 10 phút.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee18f7/1200x630cq80/photo.jpg', 15, 'Dễ', '2-3 người', 'Món xào', 'https://cookpad.com/vn/cong-thuc/kho-qua-xao-trung', 'Ánh Dương')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('6d23239c-6e49-4062-9541-dfdd39d3bd54', '2 quả khổ qua (mướp đắng) bỏ ruột thái lát mỏng', 'khổ qua', '2 quả', 1),
('6d23239c-6e49-4062-9541-dfdd39d3bd54', '3 quả trứng gà đánh tan', 'trứng', '3 quả', 1),
('6d23239c-6e49-4062-9541-dfdd39d3bd54', '2 nhánh hành lá thái nhỏ', 'hành', '2 nhánh', 1),
('6d23239c-6e49-4062-9541-dfdd39d3bd54', '3 tép tỏi băm', 'tỏi', '3 tép', 1),
('6d23239c-6e49-4062-9541-dfdd39d3bd54', '1 muỗng canh nước mắm', 'nước mắm', '1 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('6d23239c-6e49-4062-9541-dfdd39d3bd54', 1, 'Khổ qua thái lát mỏng, bóp với chút muối trong 2 phút rồi xả nước lạnh vắt ráo để giữ độ giòn và bớt đắng.', ''),
('6d23239c-6e49-4062-9541-dfdd39d3bd54', 2, 'Phi thơm tỏi băm với 1 muỗng dầu ăn, cho khổ qua vào xào trên lửa lớn trong 2 phút.', ''),
('6d23239c-6e49-4062-9541-dfdd39d3bd54', 3, 'Rưới đều trứng gà đã đánh tan vào chảo khổ qua, để 15 giây cho trứng se lại rồi đảo nhẹ tay.', ''),
('6d23239c-6e49-4062-9541-dfdd39d3bd54', 4, 'Rắc hành lá, tiêu thơm, tắt bếp và múc ra đĩa ăn kèm cơm nóng.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('6d23239c-6e49-4062-9541-dfdd39d3bd54', 190, 14.0, 8.0, 11.0, 2.5, 60.0, 2.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('6d23239c-6e49-4062-9541-dfdd39d3bd54', 'khổ qua'),
('6d23239c-6e49-4062-9541-dfdd39d3bd54', 'trứng'),
('6d23239c-6e49-4062-9541-dfdd39d3bd54', 'món xào'),
('6d23239c-6e49-4062-9541-dfdd39d3bd54', 'nhanh gọn');

-- Món ăn: Măng tây xào thịt bò dầu hào
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('590fe3eb-ff11-44d8-9c68-be23dac701e3', 'Măng tây xào thịt bò dầu hào', 'Măng tây xanh non giòn ngọt xào cùng thịt bò mềm mọng nước và sốt dầu hào tỏi phi thơm phức.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee18fa/1200x630cq80/photo.jpg', 20, 'Dễ', '3-4 người', 'Món xào', 'https://cookpad.com/vn/cong-thuc/mang-tay-xao-bo', 'Lan Anh')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('590fe3eb-ff11-44d8-9c68-be23dac701e3', '300g măng tây xanh bẻ khúc non', 'măng tây', '300g', 1),
('590fe3eb-ff11-44d8-9c68-be23dac701e3', '250g thịt thăn bò thái mỏng', 'thịt bò', '250g', 1),
('590fe3eb-ff11-44d8-9c68-be23dac701e3', '1 củ tỏi đập dập băm nhỏ', 'tỏi', '1 củ', 1),
('590fe3eb-ff11-44d8-9c68-be23dac701e3', '2 muỗng canh dầu hào', 'dầu hào', '2 muỗng', 1),
('590fe3eb-ff11-44d8-9c68-be23dac701e3', '1 muỗng cà phê tiêu xay', 'tiêu', '1 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('590fe3eb-ff11-44d8-9c68-be23dac701e3', 1, 'Thịt bò ướp với 1 muỗng dầu hào, tỏi băm, tiêu, 1 thìa dầu ăn trong 15 phút cho mềm.', ''),
('590fe3eb-ff11-44d8-9c68-be23dac701e3', 2, 'Măng tây tước sơ xơ dưới gốc, chần qua nước sôi 30 giây rồi ngâm ngay vào nước đá cho giòn xanh.', ''),
('590fe3eb-ff11-44d8-9c68-be23dac701e3', 3, 'Phi thơm tỏi, xào thịt bò trên lửa lớn đảo nhanh trong 1 phút vừa chín tới trút ra đĩa.', ''),
('590fe3eb-ff11-44d8-9c68-be23dac701e3', 4, 'Cho măng tây vào xào nhanh, trút thịt bò vào đảo đều 30 giây rồi tắt bếp bày ra đĩa.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('590fe3eb-ff11-44d8-9c68-be23dac701e3', 280, 30.0, 10.0, 12.0, 3.2, 45.0, 4.1)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('590fe3eb-ff11-44d8-9c68-be23dac701e3', 'măng tây'),
('590fe3eb-ff11-44d8-9c68-be23dac701e3', 'thịt bò'),
('590fe3eb-ff11-44d8-9c68-be23dac701e3', 'món xào'),
('590fe3eb-ff11-44d8-9c68-be23dac701e3', 'healthy');

-- Món ăn: Nộm hoa chuối tai heo giòn sần sật
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('79e99e66-1282-46e6-bd83-e0d8dd7fb866', 'Nộm hoa chuối tai heo giòn sần sật', 'Hoa chuối thái mỏng trắng muốt trộn cùng tai heo luộc giòn sần sật, lạc rang và nước mắm chua ngọt cực cuốn.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee18fd/1200x630cq80/photo.jpg', 30, 'Trung bình', '4 người', 'Gỏi/Nộm', 'https://cookpad.com/vn/cong-thuc/nom-hoa-chuoi-tai-heo', 'Bếp Quê')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', '1 bắp hoa chuối tây bào mỏng ngâm nước chanh', 'hoa chuối', '1 cái', 1),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', '1 cái tai heo cạo sạch luộc giòn thái mỏng', 'tai heo', '1 cái', 1),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', '1 củ cà rốt bào sợi', 'cà rốt', '1 củ', 1),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', '80g lạc rang giã dập', 'đậu phộng', '80g', 1),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', '1 nắm rau răm, húng quế, kinh giới', 'rau răm', '1 nắm', 1),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', '3 muỗng canh nước mắm pha tỏi ớt chanh đường', 'nước mắm', '3 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', 1, 'Hoa chuối bào mỏng ngâm ngay vào chậu nước có vắt 2 quả chanh và muối để không bị thâm đen, vớt ra vắt ráo.', ''),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', 2, 'Tai heo luộc chín cùng gừng và giấm, vớt ra ngâm nước đá lạnh rồi thái lát mỏng tang giòn rụm.', ''),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', 3, 'Pha nước sốt nộm: 3 thìa nước mắm, 2 thìa đường, 2 thìa nước cốt chanh, tỏi ớt băm khuấy tan.', ''),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', 4, 'Trộn đều hoa chuối, cà rốt, tai heo với nước sốt, bày ra đĩa rắc đậu phộng rang và rau thơm lên trên.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('79e99e66-1282-46e6-bd83-e0d8dd7fb866', 310, 22.0, 18.0, 16.0, 4.5, 70.0, 3.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', 'hoa chuối'),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', 'tai heo'),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', 'nộm'),
('79e99e66-1282-46e6-bd83-e0d8dd7fb866', 'khai vị');

-- Món ăn: Canh sườn non củ dền đỏ bổ dưỡng
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('404f865a-c2f4-41ce-b424-ad17d4e75322', 'Canh sườn non củ dền đỏ bổ dưỡng', 'Món canh ngọt lịm với màu đỏ ruby bắt mắt từ củ dền, sườn non mềm rục kết hợp cà rốt khoai tây giàu vitamin.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee1900/1200x630cq80/photo.jpg', 40, 'Dễ', '4 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/canh-suon-cu-den', 'Thanh Vân')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('404f865a-c2f4-41ce-b424-ad17d4e75322', '2 củ dền đỏ gọt vỏ cắt khối vừa ăn', 'củ dền', '2 củ', 1),
('404f865a-c2f4-41ce-b424-ad17d4e75322', '400g sườn non heo chặt khúc', 'sườn heo', '400g', 1),
('404f865a-c2f4-41ce-b424-ad17d4e75322', '1 củ cà rốt tỉa hoa xắt khúc', 'cà rốt', '1 củ', 1),
('404f865a-c2f4-41ce-b424-ad17d4e75322', '1 củ khoai tây cắt khối', 'khoai tây', '1 củ', 1),
('404f865a-c2f4-41ce-b424-ad17d4e75322', '2 nhánh hành lá và ngò rí', 'hành', '2 nhánh', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('404f865a-c2f4-41ce-b424-ad17d4e75322', 1, 'Sườn non chần qua nước sôi rửa sạch, ướp chút muối tiêu hạt nêm trong 10 phút.', ''),
('404f865a-c2f4-41ce-b424-ad17d4e75322', 2, 'Đun sôi 1.5 lít nước, cho sườn vào hầm nhỏ lửa trong 20 phút hớt sạch bọt.', ''),
('404f865a-c2f4-41ce-b424-ad17d4e75322', 3, 'Cho củ dền đỏ và cà rốt vào hầm tiếp 10 phút cho ra màu đỏ đẹp và vị ngọt thanh.', ''),
('404f865a-c2f4-41ce-b424-ad17d4e75322', 4, 'Thêm khoai tây vào nấu 5 phút cho chín tới, nêm vừa ăn, rắc hành ngò và múc ra tô.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('404f865a-c2f4-41ce-b424-ad17d4e75322', 320, 28.0, 26.0, 12.0, 4.0, 60.0, 3.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('404f865a-c2f4-41ce-b424-ad17d4e75322', 'củ dền'),
('404f865a-c2f4-41ce-b424-ad17d4e75322', 'sườn heo'),
('404f865a-c2f4-41ce-b424-ad17d4e75322', 'món canh'),
('404f865a-c2f4-41ce-b424-ad17d4e75322', 'bổ máu');

-- Món ăn: Bí ngòi xào tôm nõn tỏi thơm
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', 'Bí ngòi xào tôm nõn tỏi thơm', 'Bí ngòi xanh ngọt mọng nước xào cùng tôm nõn tươi giòn và tỏi băm thơm nức, món ăn thanh đạm ít calo.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee1903/1200x630cq80/photo.jpg', 15, 'Dễ', '3 người', 'Món xào', 'https://cookpad.com/vn/cong-thuc/bi-ngoi-xao-tom', 'Fit Meal VN')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', '2 quả bí ngòi xanh rửa sạch xắt khoanh tròn', 'bí ngòi', '2 quả', 1),
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', '200g tôm tươi bóc vỏ rút chỉ đen', 'tôm', '200g', 1),
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', '1 củ tỏi băm thơm', 'tỏi', '1 củ', 1),
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', '1 muỗng canh dầu hào', 'dầu hào', '1 muỗng', 1),
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', '2 nhánh hành lá xắt khúc', 'hành', '2 nhánh', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', 1, 'Tôm ướp chút hạt nêm, tiêu và tỏi băm trong 10 phút.', ''),
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', 2, 'Phi thơm tỏi với dầu ô liu, cho tôm vào xào săn đổi màu hồng thì trút ra đĩa.', ''),
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', 3, 'Cho bí ngòi vào xào trên lửa lớn 2-3 phút cho bí chín giòn ngọt tự nhiên.', ''),
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', 4, 'Trút tôm vào đảo đều, nêm dầu hào, rắc hành lá và tiêu thơm rồi tắt bếp ngay.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', 180, 24.0, 8.0, 5.0, 2.2, 75.0, 2.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', 'bí ngòi'),
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', 'tôm'),
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', 'món xào'),
('d22394c7-ba4a-4ae7-88c1-aba520bd79dc', 'ít calo');

-- Món ăn: Đậu bắp luộc chấm chao ớt cay
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', 'Đậu bắp luộc chấm chao ớt cay', 'Đậu bắp luộc xanh giòn ngọt mát chấm sốt chao béo ngậy pha ớt cay nồng, món ăn dân dã chống ngấy cực tốt.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee1906/1200x630cq80/photo.jpg', 10, 'Dễ', '3 người', 'Món luộc', 'https://cookpad.com/vn/cong-thuc/dau-bap-cham-chao', 'Bếp Chay')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', '400g đậu bắp non rửa sạch', 'đậu bắp', '400g', 1),
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', '3 viên chao môn hoặc chao trắng', 'chao', '3 viên', 1),
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', '1 quả ớt hiểm băm', 'ớt', '1 quả', 1),
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', '1 muỗng cà phê đường và vài giọt nước cốt chanh', 'đường', '1 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', 1, 'Đậu bắp rửa sạch, cắt bỏ cuống.', ''),
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', 2, 'Đun sôi nồi nước có chút muối, thả đậu bắp vào luộc nhanh 3-4 phút cho vừa chín tới.', ''),
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', 3, 'Vớt đậu bắp ra ngâm nước đá lạnh 2 phút để giữ màu xanh mướt và độ giòn ngọt.', ''),
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', 4, 'Tán nhuyễn chao với đường, ớt băm, nước chao và chút cốt chanh làm sốt chấm béo ngậy.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', 110, 5.0, 14.0, 4.0, 4.0, 90.0, 1.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', 'đậu bắp'),
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', 'chao'),
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', 'món luộc'),
('5f8bb2bc-ff77-4bb6-bca7-ddbdbe62ebda', 'chay');

-- Món ăn: Gà ác tiềm ngải cứu hạt sen
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('5fe95b6d-a70d-43df-bc4b-a069079bab16', 'Gà ác tiềm ngải cứu hạt sen', 'Gà ác đen hầm thuốc bắc cùng lá ngải cứu thơm nồng, hạt sen bở tơi và táo đỏ bổ dưỡng phục hồi sinh lực.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee1909/1200x630cq80/photo.jpg', 50, 'Trung bình', '2 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/ga-ac-tiem-ngai-cuu', 'Đông Y Quán')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('5fe95b6d-a70d-43df-bc4b-a069079bab16', '1 con gà ác (gà đen) làm sạch', 'thịt gà', '1 con', 1),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', '1 bó lá ngải cứu tươi non nhặt ngọn', 'ngải cứu', '1 bó', 1),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', '50g hạt sen tươi hoặc khô', 'hạt sen', '50g', 1),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', '5 quả táo tàu đỏ và kỷ tử', 'táo đỏ', '5 quả', 1),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', '1 nhánh gừng thái lát', 'gừng', '1 nhánh', 1),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', '1 muỗng canh rượu nếp', 'rượu trắng', '1 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('5fe95b6d-a70d-43df-bc4b-a069079bab16', 1, 'Gà ác bóp muối và rượu trắng rửa sạch để ráo.', ''),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', 2, 'Nhồi một phần ngải cứu, hạt sen, táo đỏ vào trong bụng gà ác.', ''),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', 3, 'Xếp phần ngải cứu còn lại và kỷ tử vào thố đất, đặt gà ác lên trên, đổ nước xăm xắp nêm chút muối hạt.', ''),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', 4, 'Hấp cách thủy hoặc hầm nhỏ lửa trong 45 phút đến khi thịt gà ác mềm rục, nước dùng ngọt đậm thơm lừng.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('5fe95b6d-a70d-43df-bc4b-a069079bab16', 420, 46.0, 22.0, 15.0, 3.8, 90.0, 6.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('5fe95b6d-a70d-43df-bc4b-a069079bab16', 'gà ác'),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', 'ngải cứu'),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', 'hạt sen'),
('5fe95b6d-a70d-43df-bc4b-a069079bab16', 'bổ dưỡng');

-- Món ăn: Canh gà lá giang chua dịu Nam Bộ
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('6e80c574-a357-4e7b-999c-4114d21e7701', 'Canh gà lá giang chua dịu Nam Bộ', 'Thịt gà ta thả vườn dai ngọt nấu cùng lá giang vò dập tiết vị chua thanh dịu, thơm nồng hương sả ớt.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee1912/1200x630cq80/photo.jpg', 30, 'Dễ', '4 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/canh-ga-la-giang', 'Cô Ba Miền Tây')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('6e80c574-a357-4e7b-999c-4114d21e7701', '600g thịt gà ta chặt miếng', 'thịt gà', '600g', 1),
('6e80c574-a357-4e7b-999c-4114d21e7701', '1 bó lá giang tươi vò nhẹ', 'lá giang', '1 bó', 1),
('6e80c574-a357-4e7b-999c-4114d21e7701', '3 cây sả đập dập băm nhỏ', 'sả', '3 cây', 1),
('6e80c574-a357-4e7b-999c-4114d21e7701', '2 quả ớt sừng', 'ớt', '2 quả', 1),
('6e80c574-a357-4e7b-999c-4114d21e7701', '1 nắm mùi tàu (ngò gai) và ngò ôm cắt nhỏ', 'ngò gai', '1 nắm', 1),
('6e80c574-a357-4e7b-999c-4114d21e7701', '2 muỗng canh nước mắm ngon', 'nước mắm', '2 muỗng', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('6e80c574-a357-4e7b-999c-4114d21e7701', 1, 'Gà ướp với sả băm, hạt nêm, tiêu, nước mắm trong 15 phút.', ''),
('6e80c574-a357-4e7b-999c-4114d21e7701', 2, 'Phi thơm tỏi sả, cho thịt gà vào xào săn trên lửa lớn.', ''),
('6e80c574-a357-4e7b-999c-4114d21e7701', 3, 'Đổ 1.2 lít nước vào đun sôi, hạ nhỏ lửa ninh 15 phút cho gà chín mềm ngọt nước.', ''),
('6e80c574-a357-4e7b-999c-4114d21e7701', 4, 'Vò dập lá giang thả vào nồi đun sôi bùng 2 phút cho tiết vị chua, nêm nếm lại, rắc ngò gai ngò ôm rồi tắt bếp.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('6e80c574-a357-4e7b-999c-4114d21e7701', 360, 38.0, 8.0, 18.0, 2.5, 60.0, 3.2)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('6e80c574-a357-4e7b-999c-4114d21e7701', 'gà lá giang'),
('6e80c574-a357-4e7b-999c-4114d21e7701', 'lá giang'),
('6e80c574-a357-4e7b-999c-4114d21e7701', 'canh chua'),
('6e80c574-a357-4e7b-999c-4114d21e7701', 'món Nam Bộ');

-- Món ăn: Canh chua cá lóc dọc mùng bạc hà
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('164b70a8-71a0-41d0-b92d-16fcff091cbb', 'Canh chua cá lóc dọc mùng bạc hà', 'Món canh chua quốc dân với cá lóc béo ngọt, dọc mùng (bạc hà) giòn xốp thấm đẫm nước me chua và dứa thơm.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee1915/1200x630cq80/photo.jpg', 30, 'Dễ', '4 người', 'Súp/Canh', 'https://cookpad.com/vn/cong-thuc/canh-chua-ca-loc-doc-mung', 'Bếp Má 5')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('164b70a8-71a0-41d0-b92d-16fcff091cbb', '500g cá lóc (cá quả) cắt khúc', 'cá', '500g', 1),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', '2 cây dọc mùng (bạc hà) tước vỏ bóp muối thái xéo', 'dọc mùng', '2 cây', 1),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', '1/4 quả thơm (dứa) xắt lát', 'dứa', '1/4 quả', 1),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', '2 quả cà chua múi cau', 'cà chua', '2 quả', 1),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', '5 quả đậu bắp xắt xéo', 'đậu bắp', '5 quả', 1),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', '50g me chín dầm lấy nước cốt', 'me', '50g', 1),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', '1 nắm ngò ôm, ngò gai thái nhỏ', 'ngò gai', '1 nắm', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('164b70a8-71a0-41d0-b92d-16fcff091cbb', 1, 'Dọc mùng tước vỏ, thái xéo rồi bóp kỹ với muối hạt 2 lần, xả sạch vắt ráo nước để không bị ngứa.', ''),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', 2, 'Phi thơm tỏi, xào cà chua và dứa cho thơm, đổ nước vào đun sôi cùng nước cốt me.', ''),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', 3, 'Thả cá lóc vào nấu chín trong 7-8 phút, vớt bọt liên tục để nước trong.', ''),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', 4, 'Thêm đậu bắp, dọc mùng vào nấu sôi 2 phút. Nêm 2 muỗng nước mắm, 1 muỗng đường cho vị chua ngọt hài hòa, rắc ngò ôm ngò gai.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('164b70a8-71a0-41d0-b92d-16fcff091cbb', 260, 28.0, 20.0, 6.5, 3.5, 80.0, 2.8)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('164b70a8-71a0-41d0-b92d-16fcff091cbb', 'cá lóc'),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', 'dọc mùng'),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', 'bạc hà'),
('164b70a8-71a0-41d0-b92d-16fcff091cbb', 'canh chua');

-- Món ăn: Nấm đùi gà kho tiêu xanh nước tương
INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
VALUES ('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', 'Nấm đùi gà kho tiêu xanh nước tương', 'Nấm đùi gà dai giòn sần sật thấm đẫm nước tương sánh đậm và tiêu xanh cay the, món chay thanh đạm đưa cơm.', 'https://img-global.cpcdn.com/recipes/5d54a22a89ee1918/1200x630cq80/photo.jpg', 20, 'Dễ', '3 người', 'Món kho/om', 'https://cookpad.com/vn/cong-thuc/nam-dui-ga-kho-tieu', 'An Nhiên')
ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);

INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', '300g nấm đùi gà cắt khoanh khứa caro', 'nấm', '300g', 1),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', '2 nhánh tiêu xanh đập dập', 'tiêu', '2 nhánh', 1),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', '3 muỗng canh nước tương ngon', 'nước tương', '3 muỗng', 1),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', '1 cây boa-rô (hành baro) thái lát', 'hành', '1 cây', 1),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', '1 muỗng cà phê dầu mè thơm', 'dầu mè', '1 muỗng', 1),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', '1 quả ớt hiểm', 'ớt', '1 quả', 1);

INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', 1, 'Nấm đùi gà rửa sạch, cắt khoanh dày 1.5cm, khứa hình vảy rồng cả 2 mặt.', ''),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', 2, 'Áp chảo nấm đùi gà với chút dầu ăn cho xém vàng 2 mặt để nấm dai thơm.', ''),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', 3, 'Pha sốt kho: 3 thìa nước tương, 1 thìa đường thốt nốt, tiêu xanh, 4 thìa nước lọc khuấy đều.', ''),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', 4, 'Rưới sốt vào chảo nấm đun nhỏ lửa 7-8 phút đến khi sốt keo lại bám đều quanh từng miếng nấm, rưới dầu mè tắt bếp.', '');

INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
VALUES ('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', 160, 8.0, 22.0, 4.5, 4.2, 30.0, 2.0)
ON DUPLICATE KEY UPDATE calories=VALUES(calories);

INSERT INTO recipe_tags (recipe_id, tag_name) VALUES
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', 'nấm đùi gà'),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', 'tiêu xanh'),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', 'món chay'),
('12c83fa9-07e8-47e3-b8e7-7dd367385fb0', 'món kho');

SET FOREIGN_KEY_CHECKS = 1;
-- Hoàn thành nạp dữ liệu Cookpad!
