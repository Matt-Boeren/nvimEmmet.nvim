return {
    -- Tags with mandatory attributes (non-void)
    ["a"]       = {'<a href=""', '>', '</a>'},
    ["script"]  = {'<script src=""', '>', '</script>'},
    ["iframe"]  = {'<iframe src=""', '>', '</iframe>'},
    ["object"]  = {'<object data=""', '>', '</object>'},

    -- Tags with mandatory attributes (void)
    ["area"]    = {'<area href=""', '/>'},
    ["base"]    = {'<base href=""', '/>'},
    ["link"]    = {'<link rel="" href=""', '/>'},
    ["meta"]    = {'<meta charset=""', '/>'}, -- could also be name/content or http-equiv/content
    ["source"]  = {'<source src=""', '/>'},
    ["track"]   = {'<track kind=""', '/>'},
    ["img"]     = {'<img src="" alt=""', '/>'},
    ["param"]   = {'<param name="" value=""', '/>'},
    ["input"]   = {'<input name="" id=""', '/>'},

    -- Void elements (no mandatory attributes)
    ["br"]      = {'<br', '/>'},
    ["col"]     = {'<col', '/>'},
    ["embed"]   = {'<embed', '/>'},
    ["hr"]      = {'<hr', '/>'},
    ["wbr"]     = {'<wbr', '/>'},

    --html structure
    ["!"] = {'<!DOCTYPE html>\n<html lang="en">\n<head>\n    <meta charset="UTF-8">\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\n    <title>Document</title>\n</head>\n<body>\n', '\n</body>\n</html>'},
}
