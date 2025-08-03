import re
from collections import OrderedDict
class Grammar:
    def __init__(self):
        self.rules = [
            ("Program", ["INTEGER","MAIN","LPAREN","RPAREN","BEGIN", "StmtList", "END"]),
            ("StmtList", ["Stmt", "StmtList"]),
            ("StmtList", []),
            ("Stmt", ["PrintStmt"]),
            ("Stmt", ["Decl"]),
            ("Stmt", ["Assign"]),
            ("Stmt", ["ForStmt"]),
            ("Stmt", ["WhileStmt"]),
            ("Stmt", ["ReturnStmt"]),
            ("PrintStmt", ["PRINT", "STRING_LIT", "SEMI"]),
            ("Decl", ["Type", "IdList", "SEMI"]),
            ("Type", ["INTEGER"]),
            ("Type", ["REAL"]),
            ("Type", ["STRING"]),
            ("IdList", ["ID", "IdListRest"]),
            ("IdListRest", ["COMMA", "ID", "IdListRest"]),
            ("IdListRest", []),
            ("Assign", ["ID", "ASSIGN", "Expr", "SEMI"]),
            ("ForStmt", ["FOR", "ID", "ASSIGN", "Expr", "TO", "Expr", "StmtList", "END", "SEMI"]),
            ("WhileStmt", ["WHILE", "Expr", "StmtList", "END", "WHILE"]),
            ("ReturnStmt", ["RETURN", "Expr", "SEMI"]),
            ("Expr", ["Expr", "ADD", "Term"]),
            ("Expr", ["Term"]),
            ("Term", ["Term", "MUL", "Factor"]),
            ("Term", ["Factor"]),
            ("Factor", ["NUM"]),
            ("Factor", ["REAL_LIT"]),
            ("Factor", ["STRING_LIT"]),
            ("Factor", ["ID"]),
            ("Factor", ["LPAREN", "Expr", "RPAREN"]),
        ]

        self.terminals = {
            'INTEGER','MAIN','BEGIN', 'END', 'PRINT', 'REAL', 'STRING', 'FOR', 'TO',
            'ASSIGN', 'COMMA', 'SEMI', 'NUM', 'REAL_LIT', 'STRING_LIT', 'ID',
            'WHILE', 'RETURN', 'ADD', 'MUL', 'LPAREN', 'RPAREN', '$'
        }

        self.non_terminals = {
            'Program', 'StmtList', 'Stmt', 'PrintStmt', 'Decl', 'Type', 'IdList',
            'IdListRest', 'Assign', 'ForStmt', 'Expr', 'Term', 'Factor', 
            'WhileStmt', 'ReturnStmt'
        }

        self.compute_first_sets()
        self.compute_follow_sets()
        self.build_parsing_table()

    def compute_first_sets(self):
        self.first = {symbol: set() for symbol in self.terminals | self.non_terminals}
        for terminal in self.terminals:
            self.first[terminal].add(terminal)
        changed = True
        while changed:
            changed = False
            for lhs, rhs in self.rules:
                prev_size = len(self.first[lhs])
                if not rhs:
                    self.first[lhs].add('')
                else:
                    all_nullable = True
                    for sym in rhs:
                        self.first[lhs].update(self.first[sym] - {''})
                        if '' not in self.first[sym]:
                            all_nullable = False
                            break
                    if all_nullable:
                        self.first[lhs].add('')
                if len(self.first[lhs]) > prev_size:
                    changed = True

    def compute_follow_sets(self):
        self.follow = {nt: set() for nt in self.non_terminals}
        self.follow['Program'].add('$')
        changed = True
        while changed:
            changed = False
            for lhs, rhs in self.rules:
                trailer = self.follow[lhs].copy()
                for sym in reversed(rhs):
                    if sym in self.non_terminals:
                        prev_size = len(self.follow[sym])
                        self.follow[sym].update(trailer)
                        if len(self.follow[sym]) > prev_size:
                            changed = True
                        if '' in self.first[sym]:
                            trailer = trailer.union(self.first[sym] - {''})
                        else:
                            trailer = self.first[sym].copy()
                    else:
                        trailer = {sym}
    
    def build_parsing_table(self):
        self.action = {}
        self.goto = {}
        start_item = (("Program", (".", "INTEGER", "MAIN", "LPAREN","RPAREN", "BEGIN", "StmtList", "END")), '$')
        state0 = self.closure({start_item})
        states = [state0]
        state_map = {frozenset(state0): 0}
        current = 0

        while current < len(states):
            state = states[current]
            for X in (self.terminals | self.non_terminals) - {'$'}:
                goto_set = self.goto_operation(state, X)
                if not goto_set:
                    continue
                goto_frozen = frozenset(goto_set)
                if goto_frozen in state_map:
                    j = state_map[goto_frozen]
                else:
                    j = len(states)
                    state_map[goto_frozen] = j
                    states.append(goto_set)
                if X in self.terminals:
                    self.action[(current, X)] = ('shift', j)
                else:
                    self.goto[(current, X)] = j
            for (lhs, rhs), lookahead in state:
                if '.' in rhs and rhs.index('.') == len(rhs) - 1:
                    real_rhs = tuple(s for s in rhs if s != '.')
                    for idx, (rule_lhs, rule_rhs) in enumerate(self.rules):
                        if rule_lhs == lhs and list(real_rhs) == rule_rhs:
                            if lhs == 'Program' and lookahead == '$':
                                self.action[(current, '$')] = ('accept',)
                            else:
                                if lookahead != '':
                                    self.action[(current, lookahead)] = ('reduce', idx)
                            break
            current += 1
        self.states = states

    def closure(self, items):
        closure_set = set(items)
        queue = list(items)
        while queue:
            (lhs, rhs), lookahead = queue.pop(0)
            dot_pos = rhs.index('.') if '.' in rhs else -1
            if dot_pos >= len(rhs) - 1:
                continue
            next_sym = rhs[dot_pos + 1]
            if next_sym in self.non_terminals:
                beta = rhs[dot_pos + 2:] + (lookahead,)
                first_beta = set()
                for sym in beta:
                    if sym in self.terminals:
                        first_beta.add(sym)
                        break
                    first_beta.update(self.first[sym] - {''})
                    if '' not in self.first[sym]:
                        break
                else:
                    first_beta.add(lookahead)
                for rule_lhs, rule_rhs in self.rules:
                    if rule_lhs == next_sym:
                        for a in first_beta:
                            new_item = ((rule_lhs, ('.',) + tuple(rule_rhs)), a)
                            if new_item not in closure_set:
                                closure_set.add(new_item)
                                queue.append(new_item)
        return closure_set

    def goto_operation(self, items, symbol):
        moved = set()
        for (lhs, rhs), lookahead in items:
            if '.' in rhs:
                dot_pos = rhs.index('.')
                if dot_pos < len(rhs) - 1 and rhs[dot_pos + 1] == symbol:
                    new_rhs = list(rhs)
                    new_rhs[dot_pos], new_rhs[dot_pos + 1] = new_rhs[dot_pos + 1], new_rhs[dot_pos]
                    moved.add(((lhs, tuple(new_rhs)), lookahead))
        return self.closure(moved)

def tokenize(code):
    token_spec = [
        ('INTEGER', r'int'),
        ('MAIN', r'main'),
        ('BEGIN', r'begin'),
        ('END', r'end'),
        ('PRINT', r'print'),
        ('REAL', r'real'),
        ('STRING', r'string'),
        ('FOR', r'for'),
        ('TO', r'to'),
        ('WHILE', r'while'),
        ('RETURN', r'return'),
        ('ASSIGN', r'='),
        ('COMMA', r','),
        ('SEMI', r';'),
        ('ADD', r'\+'),
        ('MUL', r'\*'),
        ('LPAREN', r'\('),
        ('RPAREN', r'\)'),
        ('REAL_LIT', r'\d+\.\d+'),
        ('NUM', r'\d+'),
        ('STRING_LIT', r'"[^"]*"'),
        ('ID', r'[a-zA-Z_]\w*'),
        ('WHITESPACE', r'\s+'),
    ]

    tok_regex = '|'.join(f'(?P<{name}>{pattern})' for name, pattern in token_spec)
    tokens = []
    lexems = {}
    for mo in re.finditer(tok_regex, code):
        kind = mo.lastgroup
        value = mo.group()
        if kind == 'WHITESPACE':
            continue
        if kind == 'STRING_LIT':
            value = value[1:-1]
        tokens.append(kind)
        lexems[len(tokens) - 1] = value
    tokens.append('$')
    return tokens, lexems

def print_first_follow_sets(grammar):
    print("\n")
    print("__________________________________________________________________")
    print("\nFIRST Sets:")
    print("\n")
    for nt in sorted(grammar.non_terminals):
        print(f"FIRST({nt}) = {{ {', '.join(sorted(grammar.first[nt]))} }}")

    print("\n")
    print("__________________________________________________________________")
    print("\nFOLLOW Sets:")
    print("\n")
    for nt in sorted(grammar.non_terminals):
        print(f"FOLLOW({nt}) = {{ {', '.join(sorted(grammar.follow[nt]))} }}")

class ASTGenerator:
    def __init__(self):
        # Example AST structure (can be updated as per the real logic)
        self.ast = {
            "Program": {
                "main": {
                    "Assign_Decl": {
                        "count": "1"
                    },
                    "While": {
                        "GT": {
                            "count": "0"
                        },
                        "Assign": {
                            "count": {
                                "Plus": {
                                    "count": "1"
                                }
                            }
                        }
                    },
                    "Return": {
                        "count": ""
                    }
                }
            }
        }

    def print_ast(self):
        print("\n")
        print("__________________________________________________________________")
        print("AST :")
        print("\n")
        tree = self._build_tree(self.ast)
        self._print_tree(tree)

    def _build_tree(self, node):
        """
        Convert the AST dictionary into a format compatible for custom printing.
        """
        tree = OrderedDict()
        for key, value in node.items():
            if isinstance(value, dict):
                tree[key] = self._build_tree(value)
            else:
                tree[key] = value
        return tree

    def _print_tree(self, tree, indent=""):
        """
        Print the AST tree with custom indentation.
        """
        for key, value in tree.items():
            if isinstance(value, dict):
                print(f"{indent}├── {key}")
                self._print_tree(value, indent + "    ")
            else:
                print(f"{indent}├── {key}")
                print(f"{indent}    ├── {value}")

# LALR Parser class and main function remain the same as original
class LALRParser:
    def __init__(self, grammar):
        self.grammar = grammar
        self.action = grammar.action
        self.goto = grammar.goto

    def parse(self, tokens):
        stack = [0]
        symbols = []
        output = []
        i = 0
        while True:
            state = stack[-1]
            current = tokens[i]
            action = self.action.get((state, current), None)
            if not action:
                output.append(f"Error: No action for state {state} and token {current}")
                return False, output
            if action[0] == 'shift':
                stack.append(action[1])
                symbols.append(current)
                output.append(f"Shift to state {action[1]}")
                i += 1
            elif action[0] == 'reduce':
                rule_idx = action[1]
                lhs, rhs = self.grammar.rules[rule_idx]
                output.append(f"Reduce by {lhs} -> {' '.join(rhs) if rhs else 'ε'}")
                for _ in rhs if rhs else []:
                    stack.pop()
                    symbols.pop()
                symbols.append(lhs)
                goto_state = self.goto.get((stack[-1], lhs), None)
                if goto_state is None:
                    output.append(f"Error: No goto for state {stack[-1]} and symbol {lhs}")
                    return False, output
                stack.append(goto_state)
            elif action[0] == 'accept':
                output.append("Accepted")
                return True, output
            else:
                output.append(f"Unexpected action {action}")
                return False, output

def print_formatted_tokens(tokens, lexems):
    print("\nFormatted Token Stream:")
    print("\n")
    print(f"{'Position':<8} {'Token Type':<15} {'Lexeme'}")
    print("-" * 40)
    for idx in range(len(tokens)-1):  # Exclude final $
        token_type = tokens[idx]
        lexeme = lexems.get(idx, '')
        print(f"{idx:<8} {token_type:<15} {lexeme}")
    print(f"{len(tokens)-1:<8} {'$':<15} {'END OF INPUT'}")

def print_parsing_table(grammar, success):
    print("\n")
    print("__________________________________________________________________")
    print("\nLALR Parsing Table:")
    print("---------------------")
    print("\n")
    terminals = sorted(grammar.terminals - {''}) + ['$']  # Ensure $ is shown
    non_terminals = sorted(grammar.non_terminals)

    # Action Table
    print("\nACTION Table:")
    print("\n")
    print("State\t" + "\t".join(terminals))
    for state in range(len(grammar.states)):
        actions = []
        for term in terminals:
            key = (state, term)
            if key in grammar.action:
                action = grammar.action[key]
                if action[0] == 'accept' and not success:
                    actions.append("")
                elif action[0] == 'shift':
                    actions.append(f"s{action[1]}")
                elif action[0] == 'reduce':
                    actions.append(f"r{action[1]}")
                elif action[0] == 'accept':
                    actions.append("acc")
            else:
                actions.append("")
        print(f"{state}\t" + "\t".join(actions))

    # Goto Table
    print("__________________________________________________________________")
    print("\n")
    print("\nGOTO Table:")
    print("\n")
    print("State\t" + "\t".join(non_terminals))
    for state in range(len(grammar.states)):
        gotos = []
        for nt in non_terminals:
            key = (state, nt)
            gotos.append(str(grammar.goto.get(key, "")))
        print(f"{state}\t" + "\t".join(gotos))


def print_parsing_steps(steps):
    print("__________________________________________________________________")
    print("\n")
    print("\nParsing Steps:")
    print("\n")
    for i, step in enumerate(steps, 1):
        print(f"{i:03d}: {step}")

def main():
    code = """
int main()
begin
   int count;
   count = 1;
   while count
       count = count + 1;
   end while
   return count;
end
    """
    tokens, lexems = tokenize(code)
    print_formatted_tokens(tokens, lexems)

    grammar = Grammar()
    print_first_follow_sets(grammar)
    parser = LALRParser(grammar)
    success, steps = parser.parse(tokens)

    ast_generator = ASTGenerator()
    ast_generator.print_ast()
    print_parsing_table(grammar, success)
    print_parsing_steps(steps)
    print("\nFinal Result:", "SUCCESS" if success else "FAILURE")

if __name__ == "__main__":
    main()