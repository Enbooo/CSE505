# -*- coding = utf-8 -*-
# @Time : 10/14/21 11:47 PM
# @Author : Enbo Yu
# @File : q2.py
# @Software : PyCharm

#!/usr/bin/python3

# Usgae: python q2.py <input-file> -o <output-file>

import sys


InvalidInputFile = ValueError('The input file format is invalid')


class Cnf(list):
    def __init__(self, numberp, clauses):
        self.numberp = numberp
        self.clauses = clauses


def read_clause(m, line):
    ps = [int(tok) for tok in line.split(' ')]
    if not (ps and
            all(map(lambda p: -m <= p <= m and p != 0, ps[:-1])) and
            ps[-1] == 0):
        raise ValueError('Invalid clause', line)
    return ps

def read_cnf(lines):
    if not lines:
        raise InvalidInputFile

    first_line = lines[0].split(' ')
    if len(first_line) != 4:
        raise InvalidInputFile

    p, cnf, m, n = first_line
    m, n = int(m), int(n)
    if len(lines) != n + 1:
        raise InvalidInputFile

    clauses = [read_clause(m, line) for line in lines[1:]]
    return Cnf(m, clauses)


def dump_cnf(file, cnf):
    with open(file, 'w+') as fd:
        fd.write('p cnf %d %d\n' % (cnf.numberp, len(cnf.clauses)))
        for clause in cnf.clauses:
            fd.write(' '.join(map(str, clause)) + ' 0\n')


def q2(cnf):
    m = cnf.numberp
    # c = cnf.clauses
    clauses = [[-i] for i in range(1, m + 1)]
    return Cnf(m, clauses)


def main(cmdline_args):
    if len(cmdline_args) != 4:
        print("Usage: ./q2.py <input-file> -o <output-file>")
        return
    _, input_file, _, output_file = cmdline_args
    with open(input_file, 'r') as ifd:
        lines = ifd.readlines()
        input_cnf = read_cnf(lines)
        output_cnf = q2(input_cnf)
        dump_cnf(output_file, output_cnf)
        print('generated', output_file)



if __name__ == '__main__':
    main(sys.argv)

