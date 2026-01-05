;; 1. Standard JSX Attributes (className, tw, etc.)
(jsx_attribute
  (property_identifier) @_attr_name
  (#any-of? @_attr_name "className" "class" "tw")
  (string (string_fragment) @tailwind))

;; 2. Standard call arguments: cva("text-amber-50") or cn("bg-red-500")
(call_expression
  function: (identifier) @_fn_name
  (#any-of? @_fn_name "cn" "clsx" "cva" "twMerge")
  arguments: (arguments 
    (string (string_fragment) @tailwind)))

;; 3. CVA Variants / Object Values: { primary: "text-amber-50" }
(call_expression
  function: (identifier) @_fn_name
  (#eq? @_fn_name "cva")
  arguments: (arguments
    (object
      (pair
        value: (string (string_fragment) @tailwind)))))

;; 4. Object Keys for cn/clsx: { "text-amber-50": true }
(call_expression
  function: (identifier) @_fn_name
  (#any-of? @_fn_name "cn" "clsx")
  arguments: (arguments
    (object
      (pair
        key: (string (string_fragment) @tailwind)))))
