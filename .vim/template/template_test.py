#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import unittest

import <+TEST TARGET+>


class SomeTest(unittest.TestCase):

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_something(self):
        <+CURSOR+>


if __name__ == '__main__':
    unittest.main()
