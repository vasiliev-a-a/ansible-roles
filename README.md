# 🧩🗂️ ansible-roles

## ✍️ To future me

You decided to keep roles in a separate repository to decouple them out of projects.  
In that way roles can be included as a submodule to customer's private projects.

🧠 Remember, there is always a chance that any particular package or configuration file might be in use, so try your best to keep your scope tight:

- Stick to the drop-in configuration snippets with the discriptive names when it is possible
- Preffer the _blockinfile_ to the _lineinfile_ with descriptive `marker`
- Use the `backup: true` when it is supported
- Variables can be configured on a host or group level ➡️ their names must be descriptive enough to identify a role they are related to

👍 These guidelines will maximize your role compatibility, and simplify implementations of `undo` routines.

## 🎉 To visitors

These roles were designed specifically for our environment ➡️ particular goals were set, and decisions made.

☣ Take cautions and try it in non-production environment at first.
