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
    ["wbr"]     = {'<wbr', '/>'}
}
